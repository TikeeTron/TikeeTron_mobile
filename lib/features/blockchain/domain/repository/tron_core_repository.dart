import 'package:blockchain_utils/blockchain_utils.dart' as block;
import 'package:on_chain/on_chain.dart';

import '../../data/models/result_create_wallet_model.dart';

abstract class TronCoreRepository {
  Future<ResultCreateWalletModel> createWallet({
    required block.Mnemonic mnemonic,
    required String seed,
  });
  Future<TronAccountModel?> getTronAccount({required String walletAddress});
  Future<void> getTokenBalances({required String walletAddress});
  Future<void> sendTransaction();
  Future<void> signTransaction();
  Future<double?> getTokenInFiat({required double tokenBalance});
  Future<double?> getTokenPrice();
}
