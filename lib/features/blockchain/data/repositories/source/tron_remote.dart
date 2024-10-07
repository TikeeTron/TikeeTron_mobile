import 'package:blockchain_utils/blockchain_utils.dart' as blockUtils;
import 'package:blockchain_utils/hex/hex.dart' as hex;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:on_chain/on_chain.dart';

import '../../../../../common/config/contract_config.dart';
import '../../../../../common/dio/api.config.dart';
import '../../../../../common/dio/tron_provider.dart';
import '../../../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../../common/utils/wallet_util.dart';
import '../../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../../core/injector/injector.dart';
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

    /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
    if (!request.isSuccess) {
      Logger.error('${request.error ?? request.respose}');
      return null;
    }

    /// get transactionRaw from response and make sure sed fee limit
    final rawTr = request.transactionRaw!.copyWith(feeLimit: BigInt.from(10000000));

    /// get transaaction digest and sign with private key
    final sign = privateKey.tronPrivateKey?.sign(rawTr.toBuffer());

    /// create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign!]);

    /// get raw data buffer
    final raw = blockUtils.BytesUtils.toHexString(transaction.toBuffer());

    /// send transaction to network
    final tx = await rpc.request(TronRequestBroadcastHex(transaction: raw));
    Logger.info('Send transaction success result: ${tx.respose}, txid: ${tx.txId}');

    return tx.txId;
  }

  Future<int?> calculateTransactionFee({
    required String walletAddress,
    required String targetAddress,
  }) async {
    Logger.info('calculate transaction params: sender address: $walletAddress, wallet address: $targetAddress');
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

    /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
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
  }) async {
    Logger.info('Buy Ticket Params: ticket type: $ticketType, ticket price $ticketPrice, wallet address: $walletAddress');
    final contractAddress = TronAddress("TWzCBP5F8eJhivp5Utb8cGPFjV31BQaVyd");
    final ownerAddress = TronAddress(walletAddress);
    final transferparams = [
      BigInt.from(eventId),
      'https://ipfs.io/ipfs/QmepnwHTw8Kd2ApijfeBDvFzXQBnBoFetz6i5Mrof2S3bH/0',
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
    final trc20Transfer = AbiFunctionFragment.fromJson(
      abiFunctionJson,
    );

    final request = await rpc.request(
      TronRequestTriggerConstantContract(
        ownerAddress: ownerAddress,
        callValue: BigInt.tryParse(ticketPrice.toString()) ?? BigInt.zero,
        contractAddress: contractAddress,
        data: trc20Transfer.encodeHex(transferparams),
      ),
    );
    if (!request.isSuccess) {
      Logger.error("${request.error} \n ${request.respose}");
      return null;
    }

    final contract = TriggerSmartContract(
      ownerAddress: ownerAddress,
      contractAddress: contractAddress,
      callValue: BigInt.tryParse(ticketPrice.toString()) ?? BigInt.zero,
      data: trc20Transfer.encode(transferparams),
    );
    final expireTime = DateTime.now().toUtc().add(const Duration(hours: 24));

    final parameter = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract = TransactionContract(type: contract.contractType, parameter: parameter);
    TransactionRaw rawTr = TransactionRaw(
      refBlockBytes: block.blockHeader.rawData.refBlockBytes,
      refBlockHash: block.blockHeader.rawData.refBlockHash,
      expiration: BigInt.from(expireTime.millisecondsSinceEpoch),
      feeLimit: BigInt.from(200000000),
      contract: [transactionContract],
      timestamp: block.blockHeader.rawData.timestamp,
    );

    /// get transaaction digest and sign with private key
    final sign = privateKey.tronPrivateKey?.sign(rawTr.toBuffer());

    /// create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign!]);

    /// get raw data buffer
    final raw = blockUtils.BytesUtils.toHexString(transaction.toBuffer());

    /// send transaction to network
    final tx = await rpc.request(TronRequestBroadcastHex(transaction: raw));
    Logger.info('buy ticket success result: ${tx.respose}, txid: ${tx.txId}');

    return tx.txId;
  }
}
