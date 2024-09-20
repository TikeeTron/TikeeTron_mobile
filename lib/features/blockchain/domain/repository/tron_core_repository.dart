import '../../data/models/result_create_wallet_model.dart';
import 'package:blockchain_utils/blockchain_utils.dart' as block;

abstract class TronCoreRepository {
  Future<ResultCreateWalletModel> createWallet({
    required block.Mnemonic mnemonic,
    required String seed,
  });
}
