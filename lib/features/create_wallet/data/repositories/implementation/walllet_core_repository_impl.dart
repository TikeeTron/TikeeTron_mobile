import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/root.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../common/constants/blockchain_constant.dart';
import '../../../../../common/utils/encrypter/encrypter.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../wallet/domain/repository/tron_core_repository.dart';
import '../../../domain/repository/wallet_core_repository.dart';
import '../../model/wallet_address_model.dart';
import '../../model/wallet_model.dart';
import '../source/local/wallet_local_repository.dart';

@LazySingleton(as: WalletCoreRepository)
class WallletCoreRepositoryImpl implements WalletCoreRepository {
  final TronCoreRepository _tronCoreRepository;
  final WalletLocalRepository _walletLocalRepository;

  WallletCoreRepositoryImpl(this._tronCoreRepository, this._walletLocalRepository);

  @override
  Future<WalletModel> createWallet() async {
    try {
      Logger.info('createWallet start');

      // validate wallet length
      final walletLength = getWallets().length;
      if (walletLength >= 8) {
        throw Exception("Wallet exceed maximum (${8})");
      }

      WalletModel wallet = const WalletModel();
      String walletNamePrefix = '';

      wallet = await _createNonCustodialWallet();
      walletNamePrefix = 'Wallet';

      // get app_version
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;

      wallet = wallet.copyWith(
        index: walletLength,
        name: wallet.name ?? "$walletNamePrefix-${walletLength + 1}",
        status: "Created",
        method: "input",
        readOnly: false,
        totalBalance: null,
        lastUpdate: null,
        walletPath: 0,
        createdAt: DateTime.now(),
        isGeneric: false,
        isLoading: false,
        nft: const [],
        appVersion: appVersion,
      );
      Logger.success('createWallet success: $wallet');

      return wallet;
    } catch (error) {
      Logger.error('createWallet error: $error');

      rethrow;
    }
  }

  Future<WalletModel> _createNonCustodialWallet() async {
    try {
      // generate mnemonic
      final mnemonic = await generateMnemonic(
        length: 24,
      );

      // encrypt mnemonic
      final ecnryptedSeedPhrase = EncryptEngine.encryptData(
        mnemonic.toString(),
      );

      // set mnemonic to wallet
      WalletModel wallet = WalletModel(
        seed: ecnryptedSeedPhrase,
      );

      // default blockchains
      const blockchains = BlockchainConstant.defaultBlockchains;
      for (final blockchain in blockchains) {
        switch (blockchain) {
          case BlockchainNetwork.btt:
          case BlockchainNetwork.tron:
            // create wallet
            final result = await _tronCoreRepository.createWallet(
              mnemonic: mnemonic.toString(),
            );

            // get addresses
            final addresses = wallet.addresses ?? [];

            // add new address
            addresses.add(
              WalletAddressModel(
                address: result.address,
                blockchain: blockchain,
              ),
            );

            // set addresses in wallet
            wallet = wallet.copyWith(
              addresses: addresses,
            );

            break;
        }
      }

      return wallet;
    } catch (error) {
      Logger.error('createNonCustodialWallet error: $error');

      rethrow;
    }
  }

  @override
  Future<void> deleteWallet({required int walletIndex, required String walletAddress}) {
    // TODO: implement deleteWallet
    throw UnimplementedError();
  }

  @override
  Future<Mnemonic> generateMnemonic({required int length}) async {
    try {
      Logger.info('generateMnemonic: $length');

      late WordCount wordCount;
      if (length == 12) {
        wordCount = WordCount.Words12;
      } else if (length == 18) {
        wordCount = WordCount.Words18;
      } else if (length == 24) {
        wordCount = WordCount.Words24;
      }

      final result = await _mnemonicCreator(
        wordCount: wordCount,
      );
      Logger.success('generateMnemonic success: $result');

      return result;
    } catch (error) {
      Logger.error('generateMnemonic error: $error');

      rethrow;
    }
  }

  Future<Mnemonic> _mnemonicCreator({
    required WordCount wordCount,
  }) async {
    try {
      final mnemonic = await Mnemonic.create(wordCount);

      return mnemonic;
    } catch (e) {
      rethrow;
    }
  }

  @override
  double getAllWalletsBalance() {
    // TODO: implement getAllWalletsBalance
    throw UnimplementedError();
  }

  @override
  String getWalletAddress({required WalletModel wallet, BlockchainNetwork? blockchain}) {
    // TODO: implement getWalletAddress
    throw UnimplementedError();
  }

  @override
  Future<String> getWalletAddressFromSeed({required String seed, required BlockchainNetwork blockchain}) {
    // TODO: implement getWalletAddressFromSeed
    throw UnimplementedError();
  }

  @override
  List<String> getWalletAddresses({required WalletModel wallet}) {
    // TODO: implement getWalletAddresses
    throw UnimplementedError();
  }

  @override
  List<BlockchainNetwork?> getWalletBlockchainList({required WalletModel wallet, bool? selectFromTokenList}) {
    // TODO: implement getWalletBlockchainList
    throw UnimplementedError();
  }

  @override
  WalletModel getWalletByAddress({required String address, required BlockchainNetwork blockchain}) {
    // TODO: implement getWalletByAddress
    throw UnimplementedError();
  }

  @override
  int getWalletIndex({required WalletModel wallet}) {
    // TODO: implement getWalletIndex
    throw UnimplementedError();
  }

  @override
  List<WalletModel> getWallets() {
    try {
      Logger.info("getWallets");

      final result = _walletLocalRepository.getAll();
      Logger.success("getWallets result: $result");
      if (result == null) {
        return [];
      }

      return result.map((e) => WalletModel.fromJson(e)).toList();
    } catch (error) {
      Logger.error('getWallets error: $error');

      rethrow;
    }
  }

  @override
  Future<WalletModel> importWallet({String? seed}) {
    // TODO: implement importWallet
    throw UnimplementedError();
  }

  @override
  bool isMustMigrateWallet() {
    // TODO: implement isMustMigrateWallet
    throw UnimplementedError();
  }

  @override
  Future<Map> migrateHotWallet({required Map wallet, required int walletIndex}) {
    // TODO: implement migrateHotWallet
    throw UnimplementedError();
  }

  @override
  Future<void> saveAddressToBackend({required String? walletAddress}) {
    // TODO: implement saveAddressToBackend
    throw UnimplementedError();
  }

  @override
  Future<void> saveWallet({required WalletModel? wallet}) {
    // TODO: implement saveWallet
    throw UnimplementedError();
  }

  @override
  Future<void> updateWalletData({required int walletIndex, required List keyValue}) {
    // TODO: implement updateWalletData
    throw UnimplementedError();
  }
}
