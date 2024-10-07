import 'package:blockchain_utils/blockchain_utils.dart' as block;
import 'package:on_chain/on_chain.dart';

import '../../../wallet/data/model/wallet_model.dart';
import '../../data/models/result_create_wallet_model.dart';

abstract class TronCoreRepository {
  Future<ResultCreateWalletModel> createWallet({
    required block.Mnemonic mnemonic,
    required String seed,
  });
  Future<TronAccountModel?> getTronAccount({required String walletAddress});
  Future<void> getTokenBalances({required String walletAddress});
  Future<String?> sendTransaction({
    required String walletAddress,
    required String targetAddress,
    required String amount,
    required WalletModel wallet,
  });
  Future<double?> getTokenInFiat({required double tokenBalance});
  Future<double?> getTokenPrice();
  Future<int?> getNetworkFee({
    required String walletAddress,
    required String targetAddress,
  });

  Future<String?> buyTicket({
    required String ticketType,
    required String walletAddress,
    required int ticketPrice,
    required int eventId,
    required WalletModel wallet,
  });
}
