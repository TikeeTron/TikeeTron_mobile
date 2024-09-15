import '../../data/models/result_create_wallet_model.dart';

abstract class TronCoreRepository {
  Future<ResultCreateWalletModel> createWallet({
    required String mnemonic,
  });
}
