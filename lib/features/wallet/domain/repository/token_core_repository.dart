import 'package:web3dart/web3dart.dart';

import '../../../../core/adapters/blockchain_network_adapter.dart';
import '../../data/model/estimate_send_crypto_model.dart';
import '../../data/model/gas_price_model.dart';
import '../../data/model/token_model.dart';
import '../../data/model/token_price_model.dart';
import '../../data/model/wallet_model.dart';

abstract class TokenCoreRepository {
  Future<void> getTokensBalance({
    required int walletIndex,
    bool? forceUpdate,
  });
  Future<BigInt> getERC1155Balance({
    required String networkName,
    required String contractAddress,
    required String walletAddress,
    required String tokenId,
  });
  Future<List<TokenPriceModel>> getCoinsPrice({
    required List<String> coinsId,
  });
  Future<GasPriceModel> getCurrentGasPrice({
    required bool isEip1559Support,
    required Web3Client web3Client,
  });
  Future<EstimateSendCryptoModel> estimateTransfer({
    required String targetAddress,
    required double amount,
    required WalletModel wallet,
    required TokenModel token,
    required String chain,
    BigInt? gasLimit,
    BigInt? maxFee,
    BigInt? maxPriorityFee,
  });
  Future<BigInt> getAddressBalance({
    required String address,
    required BlockchainNetwork blockchain,
    String? chainId,
    String? contractAddress,
    int? decimals,
  });
}
