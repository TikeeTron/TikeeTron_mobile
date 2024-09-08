import 'package:bdk_flutter/bdk_flutter.dart';

import '../../../../core/adapters/blockchain_network_adapter.dart';
import '../../data/model/wallet_model.dart';

abstract class WalletCoreRepository {
  Future<Mnemonic> generateMnemonic({
    required int length,
  });
  Future<WalletModel> createWallet();
  Future<WalletModel> importWallet({
    String? seed,
  });
  Future<void> saveWallet({
    required WalletModel? wallet,
  });
  Future<void> saveAddressToBackend({
    required String? walletAddress,
  });

  Future<void> updateWalletData({
    required int walletIndex,
    required List keyValue,
  });
  List<WalletModel> getWallets();
  String getWalletAddress({
    required WalletModel wallet,
    BlockchainNetwork? blockchain,
  });
  List<String> getWalletAddresses({
    required WalletModel wallet,
  });
  int getWalletIndex({
    required WalletModel wallet,
  });
  List<BlockchainNetwork?> getWalletBlockchainList({
    required WalletModel wallet,
    bool? selectFromTokenList,
  });
  WalletModel getWalletByAddress({
    required String address,
    required BlockchainNetwork blockchain,
  });
  double getAllWalletsBalance();
  bool isMustMigrateWallet();
  Future<Map<dynamic, dynamic>> migrateHotWallet({
    required Map<dynamic, dynamic> wallet,
    required int walletIndex,
  });

  Future<void> deleteWallet({
    required int walletIndex,
    required String walletAddress,
  });
  Future<String> getWalletAddressFromSeed({
    required String seed,
    required BlockchainNetwork blockchain,
  });
}
