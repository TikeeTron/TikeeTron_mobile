import 'package:blockchain_utils/blockchain_utils.dart' as block;
import 'package:injectable/injectable.dart';
import 'package:on_chain/on_chain.dart';
import '../../../../../common/utils/encrypter/encrypter.dart';
import '../../../../../common/utils/extensions/object_parsing.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../../common/utils/wallet_util.dart';
import '../../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../../core/injector/locator.dart';
import '../../../../wallet/data/model/wallet_model.dart';
import '../../../domain/repository/tron_core_repository.dart';
import '../../models/result_create_wallet_model.dart';
import '../source/tron_remote.dart';

@LazySingleton(as: TronCoreRepository)
class TronCoreRepositoryImpl implements TronCoreRepository {
  final TronRemote _tronRemote;
  TronCoreRepositoryImpl(this._tronRemote);
  @override
  Future<ResultCreateWalletModel> createWallet({required block.Mnemonic mnemonic, required String seed}) async {
    try {
      Logger.info("createWallet");

      final privateKeyResult = await locator<WalletUtils>().extractPrivateKeyFromSeed(
        mnemonic: mnemonic,
        blockchain: BlockchainNetwork.tron,
      );
      final publicKey = privateKeyResult.tronPrivateKey?.publicKey();
      ResultCreateWalletModel result = ResultCreateWalletModel(
        address: publicKey?.toAddress().toAddress(),
        seed: seed,
        blockchainNetwork: BlockchainNetwork.tron,
        privateKey: privateKeyResult.privateKey,
      );

      // set encrypted private key
      final privateKey = privateKeyResult.privateKey;
      if (privateKey != null) {
        final ecnryptedPrivateKey = EncryptEngine.encryptData(privateKey);
        result = result.copyWith(
          ecnryptedPrivateKey: ecnryptedPrivateKey,
        );
      }

      return result;
    } catch (error) {
      Logger.error('createWallet error: $error');

      rethrow;
    }
  }

  @override
  Future<void> getTokenBalances({required String walletAddress}) async {
    try {
      await _tronRemote.getTokenBalance(walletAddress: walletAddress);
    } catch (e) {
      Logger.error(e.toString());
      rethrow;
    }
  }

  @override
  Future<String?> sendTransaction({
    required String walletAddress,
    required String targetAddress,
    required String amount,
    required WalletModel wallet,
  }) async {
    try {
      final txId = await _tronRemote.sendTransaction(
        walletAddress: walletAddress,
        targetAddress: targetAddress,
        amount: amount,
        wallet: wallet,
      );
      return txId;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TronAccountModel?> getTronAccount({required String walletAddress}) async {
    try {
      final result = await _tronRemote.getTronAccount(walletAddress: walletAddress);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<double?> getTokenInFiat({required double tokenBalance}) async {
    try {
      final tokenPrice = await _tronRemote.getTokenPrice();
      final tokenInFiat = tokenBalance * (tokenPrice ?? 0.1) * 1.00;
      return tokenInFiat;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<double?> getTokenPrice() async {
    try {
      final tokenPrice = await _tronRemote.getTokenPrice();

      return tokenPrice;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> getNetworkFee({
    required String walletAddress,
    required String targetAddress,
  }) async {
    try {
      final result = await _tronRemote.calculateTransactionFee(
        walletAddress: walletAddress,
        targetAddress: targetAddress,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> buyTicket({
    required String ticketType,
    required String walletAddress,
    required int ticketPrice,
    required int eventId,
    required WalletModel wallet,
  }) async {
    try {
      final txId = await _tronRemote.buyTicket(
        walletAddress: walletAddress,
        ticketType: ticketType,
        ticketPrice: ticketPrice,
        wallet: wallet,
        eventId: eventId,
      );
      return txId;
    } catch (e) {
      Logger.error('Failed Buy Ticket ${e.errorMessage}');
      return null;
    }
  }
}
