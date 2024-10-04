import 'package:blockchain_utils/hex/hex.dart' as hex;
import 'package:injectable/injectable.dart';
import 'package:on_chain/on_chain.dart';
import 'package:blockchain_utils/blockchain_utils.dart' as blockUtils;
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
      print(request.error ?? request.respose);
      return null;
    }

    /// get transactionRaw from response and make sure sed fee limit
    final rawTr = request.transactionRaw!.copyWith(feeLimit: BigInt.from(10000000));

    // txID
    final _ = rawTr.txID;

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

  Future<int?> getTransactionInfo({required String transactionId}) async {
    final transactionInfo = await rpc.request(
      TronRequestGetTransactionInfoById(value: transactionId),
    );
    final result = TronTransactionInfoModel.fromJson(transactionInfo);
    return result.receipt?.netUsage;
  }
}
