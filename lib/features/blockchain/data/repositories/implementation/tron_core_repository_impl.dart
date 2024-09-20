import 'package:injectable/injectable.dart';
import 'package:tron/tron.dart' as tron;
import 'package:blockchain_utils/blockchain_utils.dart' as block;
import '../../../../../common/utils/encrypter/encrypter.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../../common/utils/wallet_util.dart';
import '../../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../../core/injector/locator.dart';
import '../../../domain/repository/tron_core_repository.dart';
import '../../models/result_create_wallet_model.dart';

@LazySingleton(as: TronCoreRepository)
class TronCoreRepositoryImpl implements TronCoreRepository {
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
}
