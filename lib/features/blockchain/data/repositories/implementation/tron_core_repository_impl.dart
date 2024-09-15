import 'package:injectable/injectable.dart';

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
  Future<ResultCreateWalletModel> createWallet({required String mnemonic}) async {
    try {
      Logger.info("createWallet");

      final privateKeyResult = await locator<WalletUtils>().extractPrivateKeyFromSeed(
        mnemonic,
        '',
        blockchain: BlockchainNetwork.tron,
      );

      ResultCreateWalletModel result = ResultCreateWalletModel(
        address: privateKeyResult.ethPrivateKey?.address.hexEip55,
        seed: mnemonic,
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
