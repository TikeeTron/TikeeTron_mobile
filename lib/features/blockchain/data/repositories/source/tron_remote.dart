import 'package:blockchain_utils/blockchain_utils.dart' as blockUtils;
import 'package:blockchain_utils/hex/hex.dart' as hex;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:on_chain/on_chain.dart';

import '../../../../../common/config/contract_config.dart';
import '../../../../../common/dio/api.config.dart';
import '../../../../../common/dio/rpc_service.dart';
import '../../../../../common/dio/tron_provider.dart';
import '../../../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../../common/utils/wallet_util.dart';
import '../../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../../core/injector/injector.dart';
import '../../../../home/data/model/request/snyc_ticket_request.dart';
import '../../../../wallet/data/model/wallet_model.dart';
import '../../models/tron_transaction_info_model.dart';

@LazySingleton()
class TronRemote {
  final rpc = TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io/"));

  Future<void> getTokenBalance({required String walletAddress}) async {
    final block = await rpc.request(TronRequestGetNowBlock());

    final blockHash = hex.hex.encode(block.blockHeader.rawData.parentHash ?? []);
    Logger.info('BLOCK HASH INFO ===> parent hash: ${blockHash}, raw hash:  ${block.blockID}, block Id: ${block.blockHeader.rawData.number.toString()}');
    final balance = await rpc.request(
      TronRequestGetAccount(
        address: TronAddress(walletAddress),
      ),
    );
    Logger.info('Account balance info $balance');
  }

  Future<TronAccountModel?> getTronAccount({required String walletAddress}) async {
    final tronAccount = await rpc.request(
      TronRequestGetAccount(
        address: TronAddress(walletAddress),
      ),
      const Duration(seconds: 5),
    );
    Logger.info('Account info $tronAccount');

    return tronAccount;
  }

  Future<double?> getTokenPrice() async {
    final result = await AppApi().getWithCache(
      'https://api.coingecko.com/api/v3/simple/token_price/tron?contract_addresses=TNUC9Qb1rRpS5CbWLmNMxXBjyFoydXjWFR&vs_currencies=usd',
    );
    if (result != null) {
      final tokenPrice = result['TNUC9Qb1rRpS5CbWLmNMxXBjyFoydXjWFR']['usd'];
      return tokenPrice;
    } else {
      return null;
    }
  }

  Future<String?> sendTransaction({
    required String walletAddress,
    required String targetAddress,
    required String amount,
    required WalletModel wallet,
  }) async {
    Logger.info('Send transaction params: sender address: $walletAddress, wallet address: $targetAddress, amount: $amount');
    // Extract private key from wallet seed
    final seed = DynamicParsing(wallet.seed).privateKeyDecrypt;
    final privateKey = await locator<WalletUtils>().extractPrivateKeyFromSeed(
      mnemonic: blockUtils.Mnemonic.fromString(seed ?? ''),
      blockchain: BlockchainNetwork.tron,
    );

    // Define the receiving Tron address for the transaction.
    final receiverAddress = TronAddress(targetAddress);
    final ownerAddress = TronAddress(walletAddress);
    // create transfer contract
    final transferContract = TransferContract(
      amount: TronHelper.toSun(amount),
      ownerAddress: ownerAddress,
      toAddress: receiverAddress,
    );

    final request = await rpc.request(
      TronRequestCreateTransaction.fromContract(
        transferContract,
        visible: false,
      ),
    );

    // An error has occurred with the request, and we need to investigate the issue to determine what is happening.
    if (!request.isSuccess) {
      Logger.error('${request.error ?? request.respose}');
      return null;
    }

    // get transactionRaw from response and make sure sed fee limit
    final rawTr = request.transactionRaw!.copyWith(feeLimit: BigInt.from(10000000));

    // get transaaction digest and sign with private key
    final sign = privateKey.tronPrivateKey?.sign(rawTr.toBuffer());

    // create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign!]);

    // get raw data buffer
    final raw = blockUtils.BytesUtils.toHexString(transaction.toBuffer());

    // send transaction to network
    final tx = await rpc.request(TronRequestBroadcastHex(transaction: raw));
    Logger.info('Send transaction success result: ${tx.respose}, txid: ${tx.txId}');

    return tx.txId;
  }

  Future<int?> calculateTransactionFee({
    required String walletAddress,
    required String targetAddress,
  }) async {
    Logger.info('calculate transaction params: sender address: $walletAddress, target address: $targetAddress');
    // Define the receiving Tron address for the transaction.
    final receiverAddress = TronAddress(targetAddress);
    final ownerAddress = TronAddress(walletAddress);
    // create transfer contract
    final transferContract = TransferContract(
      amount: TronHelper.toSun('1'),
      ownerAddress: ownerAddress,
      toAddress: receiverAddress,
    );

    final request = await rpc.request(
      TronRequestCreateTransaction.fromContract(
        transferContract,
        visible: true,
      ),
    );

    // An error has occurred with the request, and we need to investigate the issue to determine what is happening.
    if (!request.isSuccess) {
      Logger.error('${request.error ?? request.respose}');
      return null;
    }

    final rawTr = request.transactionRaw!.copyWith(feeLimit: BigInt.from(10000000));
    final fakeTransaction = Transaction(rawData: rawTr, signature: [Uint8List(65)]);

    // Calculate the total size of the fake transaction, considering the required network overhead.
    final transactionSize = fakeTransaction.length + 64;

    // Assign the calculated size to the variable representing the required bandwidth.
    int requiredBandwidth = transactionSize;

    return requiredBandwidth;
  }

  Future<int?> getTransactionInfo({required String transactionId}) async {
    final transactionInfo = await rpc.request(
      TronRequestGetTransactionInfoById(value: transactionId),
    );
    final result = TronTransactionInfoModel.fromJson(transactionInfo);
    return result.receipt?.netUsage;
  }

  Future<String?> buyTicket({
    required String ticketType,
    required int ticketPrice,
    required String walletAddress,
    required int eventId,
    required WalletModel wallet,
    required String accessToken,
  }) async {
    Logger.info('Buy Ticket Params: ticket type: $ticketType, ticket price $ticketPrice, wallet address: $walletAddress, eventID: $eventId');

    final formData = FormData.fromMap({
      'ticketType': ticketType,
      'price': ticketPrice,
      'eventId': eventId,
      'type': 'ticket',
    });

    final ipfsUrl = await AppApi(
      version: 1,
    ).post(
      '/ipfs',
      body: formData,
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'multipart/form-data',
      }),
    );
    final contractAddress = TronAddress("TVPysSf43yPBiQNZ7Fq8Fhwx3E4Fqj6kRv");
    final ownerAddress = TronAddress(walletAddress);
    final transferparams = [
      BigInt.from(eventId),
      ipfsUrl['data'] ?? '',
      ticketType,
    ];

    final seed = DynamicParsing(wallet.seed).privateKeyDecrypt;
    final privateKey = await locator<WalletUtils>().extractPrivateKeyFromSeed(
      mnemonic: blockUtils.Mnemonic.fromString(seed ?? ''),
      blockchain: BlockchainNetwork.tron,
    );

    final block = await rpc.request(TronRequestGetNowBlock());

    final abiFunctionJson = ContractConfig.abi.firstWhere(
      (element) => element['name'] == 'buyTicket',
      orElse: () => throw Exception('Function not found in ABI'),
    );
    Logger.info('Abi Config $abiFunctionJson');
    final nftPayment = AbiFunctionFragment.fromJson(
      abiFunctionJson,
    );

    final request = await rpc.request(
      TronRequestTriggerConstantContract(
        ownerAddress: ownerAddress,
        callValue: BigInt.tryParse(ticketPrice.toString()) ?? BigInt.zero,
        contractAddress: contractAddress,
        data: nftPayment.encodeHex(transferparams),
      ),
    );
    if (!request.isSuccess) {
      Logger.error("${request.error} \n ${request.respose}");
      return null;
    }

    final rawTrReq = request.transactionRaw!.copyWith(
      feeLimit: TronHelper.toSun("275"),
      refBlockBytes: block.blockHeader.rawData.refBlockBytes,
      refBlockHash: block.blockHeader.rawData.refBlockHash,
    );

    // get transaaction digest and sign with private key
    final sign = privateKey.tronPrivateKey?.sign(rawTrReq.toBuffer());

    // create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTrReq, signature: [sign!]);

    // get raw data buffer
    final raw = blockUtils.BytesUtils.toHexString(transaction.toBuffer());

    // send transaction to network
    final tx = await rpc.request(TronRequestBroadcastHex(transaction: raw));

    final contract = ContractABI.fromJson(ContractConfig.abi);
    final rpcHttp = EVMRPC(RPCHttpService("https://api.shasta.trongrid.io/jsonrpc"));
    final callGetTicketId = await rpcHttp.request(
      RPCCall.fromMethod(
        contractAddress: contractAddress.toAddress(false),
        function: contract.functionFromName("_ticketId"),
        params: [],
      ),
    );

    Logger.info('CALL GET TICKET ID ${callGetTicketId[0]}');

    // snyc ticket data to backend
    await AppApi(
      version: 1,
    ).post(
      '/tickets',
      body: SyncTicketRequest(
        buyerAddress: walletAddress,
        eventId: eventId,
        metadataUrl: ipfsUrl['data'],
        price: ticketPrice,
        ticketId: int.tryParse(callGetTicketId[0].toString()) ?? 0,
        type: ticketType,
      ).toJson(),
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );
    Logger.info('buy ticket success result: ${tx.respose}, txid: ${tx.txId}');

    return tx.txId;
  }

  Future<String?> sendTicket({
    required String walletAddress,
    required String targetAddress,
    required String accessToken,
    required int ticketId,
    required int ticketPrice,
    required WalletModel wallet,
    required bool isTicketUsed,
  }) async {
    Logger.info('Buy Ticket Params: wallet address: $walletAddress');
    final contractAddress = TronAddress("TVPysSf43yPBiQNZ7Fq8Fhwx3E4Fqj6kRv");
    final ownerAddress = TronAddress(walletAddress);
    final toAddress = TronAddress(targetAddress);

    final transferparams = [
      ownerAddress,
      toAddress,
      BigInt.from(ticketId),
    ];

    final seed = DynamicParsing(wallet.seed).privateKeyDecrypt;
    final privateKey = await locator<WalletUtils>().extractPrivateKeyFromSeed(
      mnemonic: blockUtils.Mnemonic.fromString(seed ?? ''),
      blockchain: BlockchainNetwork.tron,
    );

    final block = await rpc.request(TronRequestGetNowBlock());

    final abiFunctionJson = ContractConfig.abi.firstWhere(
      (element) => element['name'] == 'safeTransferFrom',
      orElse: () => throw Exception('Function not found in ABI'),
    );
    Logger.info('Abi Config $abiFunctionJson');
    final sendNftContract = AbiFunctionFragment.fromJson(
      abiFunctionJson,
    );

    final request = await rpc.request(
      TronRequestTriggerConstantContract(
        ownerAddress: ownerAddress,
        contractAddress: contractAddress,
        data: sendNftContract.encodeHex(transferparams),
      ),
    );
    if (!request.isSuccess) {
      Logger.error("${request.error} \n ${request.respose}");
      return null;
    }

    final rawTrReq = request.transactionRaw!.copyWith(
      feeLimit: TronHelper.toSun("275"),
      refBlockBytes: block.blockHeader.rawData.refBlockBytes,
      refBlockHash: block.blockHeader.rawData.refBlockHash,
    );

    // get transaaction digest and sign with private key
    final sign = privateKey.tronPrivateKey?.sign(rawTrReq.toBuffer());

    // create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTrReq, signature: [sign!]);

    // get raw data buffer
    final raw = blockUtils.BytesUtils.toHexString(transaction.toBuffer());

    // send transaction to network
    final tx = await rpc.request(TronRequestBroadcastHex(transaction: raw));

    // Snyc data with backend
    await AppApi(
      version: 1,
    ).patch(
      '/tickets/$ticketId',
      body: {
        'buyerAddress': targetAddress,
        'price': ticketPrice,
        'isUsed': isTicketUsed,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );
    Logger.info('send ticket success result: ${tx.respose}, txid: ${tx.txId}');

    return tx.txId;
  }
}
