import 'package:web3dart/web3dart.dart';

import '../../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../blockchain/domain/repository/tron_core_repository.dart';
import '../../../domain/repository/token_core_repository.dart';
import '../../../domain/repository/wallet_core_repository.dart';
import '../../model/estimate_send_crypto_model.dart';
import '../../model/gas_price_model.dart';
import '../../model/token_model.dart';
import '../../model/token_price_model.dart';
import '../../model/wallet_model.dart';
import '../source/local/account_local_repository.dart';

class TokenCoreRepositoryImpl implements TokenCoreRepository {
  final TronCoreRepository tronCore;
  final WalletCoreRepository walletCore;
  final AccountLocalRepository accountLocalRepository;

  const TokenCoreRepositoryImpl({
    required this.tronCore,
    required this.walletCore,
    required this.accountLocalRepository,
  });

  @override
  Future<EstimateSendCryptoModel> estimateTransfer(
      {required String targetAddress,
      required double amount,
      required WalletModel wallet,
      required TokenModel token,
      required String chain,
      BigInt? gasLimit,
      BigInt? maxFee,
      BigInt? maxPriorityFee}) {
    // TODO: implement estimateTransfer
    throw UnimplementedError();
  }

  @override
  Future<BigInt> getAddressBalance({required String address, required BlockchainNetwork blockchain, String? chainId, String? contractAddress, int? decimals}) {
    // TODO: implement getAddressBalance
    throw UnimplementedError();
  }

  @override
  Future<List<TokenPriceModel>> getCoinsPrice({required List<String> coinsId}) {
    // TODO: implement getCoinsPrice
    throw UnimplementedError();
  }

  @override
  Future<GasPriceModel> getCurrentGasPrice({required bool isEip1559Support, required Web3Client web3Client}) {
    // TODO: implement getCurrentGasPrice
    throw UnimplementedError();
  }

  @override
  Future<BigInt> getERC1155Balance({required String networkName, required String contractAddress, required String walletAddress, required String tokenId}) {
    // TODO: implement getERC1155Balance
    throw UnimplementedError();
  }

  @override
  Future<void> getTokensBalance({required int walletIndex, bool? forceUpdate}) {
    // TODO: implement getTokensBalance
    throw UnimplementedError();
  }
}
