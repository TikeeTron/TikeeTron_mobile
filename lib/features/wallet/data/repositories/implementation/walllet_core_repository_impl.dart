import 'package:blockchain_utils/blockchain_utils.dart' as block;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../common/constants/blockchain_constant.dart';
import '../../../../../common/dio/api.config.dart';
import '../../../../../common/utils/encrypter/encrypter.dart';
import '../../../../../common/utils/extensions/dynamic_parsing.dart';
import '../../../../../common/utils/extensions/object_parsing.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../../common/utils/wallet_util.dart';
import '../../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../../core/injector/locator.dart';
import '../../../../blockchain/domain/repository/tron_core_repository.dart';
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
        mnemonic.toStr(),
      );

      // set mnemonic to wallet
      WalletModel wallet = WalletModel(
        seed: ecnryptedSeedPhrase,
      );
      final seed = block.Bip39SeedGenerator(mnemonic).generate();

      // default blockchains
      const blockchains = BlockchainConstant.defaultBlockchains;
      for (final blockchain in blockchains) {
        switch (blockchain) {
          case BlockchainNetwork.btt:
          case BlockchainNetwork.tron:
            // create wallet
            final result = await _tronCoreRepository.createWallet(
              mnemonic: mnemonic,
              seed: seed.toString(),
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
  Future<void> deleteWallet({required int walletIndex, required String walletAddress}) async {
    try {
      Logger.info(
        'deleteWallet params: walletIndex $walletIndex, '
        'walletAddress $walletAddress',
      );
      // delete wallet from repository
      await _walletLocalRepository.deleteAt(walletIndex);

      Logger.success('deleteWallet success');
    } catch (error) {
      Logger.error('deleteWallet error: $error');

      rethrow;
    }
  }

  @override
  Future<block.Mnemonic> generateMnemonic({required int length}) async {
    try {
      Logger.info('generateMnemonic: $length');

      late block.Bip39WordsNum wordCount;
      if (length == 12) {
        wordCount = block.Bip39WordsNum.wordsNum12;
      } else if (length == 18) {
        wordCount = block.Bip39WordsNum.wordsNum18;
      } else if (length == 24) {
        wordCount = block.Bip39WordsNum.wordsNum24;
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

  Future<block.Mnemonic> _mnemonicCreator({
    required block.Bip39WordsNum wordCount,
  }) async {
    try {
      Logger.success('mnemonic cretor params: ${wordCount.value}');

      final mnemonic = await block.Bip39MnemonicGenerator().fromWordsNumber(wordCount);

      Logger.success('mnemonic cretor success: ${mnemonic.toList()}');

      return mnemonic;
    } catch (e) {
      rethrow;
    }
  }

  @override
  double getAllWalletsBalance() {
    try {
      Logger.info('getAllWalletsBalance');

      double result = 0;

      // get wallets
      final wallets = getWallets();
      for (final wallet in wallets) {
        // get wallet balance
        final walletBalance = DynamicParsing(wallet.totalBalance).dynamicToDouble;

        // add wallet balance to result
        result += walletBalance ?? 0;
      }

      Logger.success('getAllWalletsBalance success: $result');

      return result;
    } catch (error) {
      Logger.error('getAllWalletsBalance error: $error');

      rethrow;
    }
  }

  @override
  String getWalletAddress({required WalletModel wallet, BlockchainNetwork? blockchain}) {
    try {
      Logger.info('getWalletAddress params: wallet ${wallet.addresses}, blockchain $blockchain');

      String? address;
      final walletAddresses = wallet.addresses ?? [];
      for (final walletAddress in walletAddresses) {
        if (blockchain == null) {
          address = walletAddress.address;
          break;
        }

        if (walletAddress.blockchain == blockchain) {
          address = walletAddress.address;
          break;
        }
      }

      Logger.success('getWalletAddress address: $address');
      if (address == null) {
        throw Exception('Failed to get wallet address');
      }

      return address;
    } catch (error) {
      Logger.error('getWalletAddress error: $error');

      rethrow;
    }
  }

  @override
  Future<String> getWalletAddressFromSeed({required block.Mnemonic seed, required BlockchainNetwork blockchain}) async {
    try {
      Logger.info('getWalletAddressFromSeed params: seed $seed, blockchain $blockchain');

      late String result;

      // extract credential from seed
      final extracted = await locator<WalletUtils>().extractPrivateKeyFromSeed(
        blockchain: blockchain,
        mnemonic: seed,
      );

      switch (blockchain) {
        case BlockchainNetwork.btt:
        case BlockchainNetwork.tron:
          final publicKey = extracted.tronPrivateKey?.publicKey();
          final address = publicKey?.toAddress().toAddress();
          if (address == null) {
            throw 'Failed to get EVM address from seed';
          }

          result = address;

          break;
      }

      Logger.success('getWalletAddressFromSeed success: $result');

      return result;
    } catch (error) {
      Logger.error('getWalletAddressFromSeed error: $error');

      rethrow;
    }
  }

  @override
  List<String> getWalletAddresses({required WalletModel wallet}) {
    try {
      Logger.info('getWalletAddresses params: wallet $wallet');

      final List<String> result = [];
      final walletAddresses = wallet.addresses ?? [];
      for (final walletAddress in walletAddresses) {
        final address = walletAddress.address;
        if (address != null) {
          result.add(address);
        }
      }

      Logger.success('getWalletAddresses result: $result');

      return result;
    } catch (error) {
      Logger.error('getWalletAddresses error: $error');

      rethrow;
    }
  }

  @override
  List<BlockchainNetwork?> getWalletBlockchainList({required WalletModel wallet, bool? selectFromTokenList}) {
    // TODO: implement getWalletBlockchainList
    throw UnimplementedError();
  }

  @override
  WalletModel getWalletByAddress({required String address, required BlockchainNetwork blockchain}) {
    try {
      Logger.info('getWalletByAddress params: address $address, blockchain $blockchain');

      WalletModel? result;

      // get wallets
      final wallets = getWallets();
      for (final wallet in wallets) {
        // check if wallet address is in token list
        // fixed issue when wallet address is not in token list
        for (final WalletAddressModel item in wallet.addresses ?? []) {
          if (item.address?.toLowerCase() == address.toLowerCase() && item.blockchain == blockchain) {
            result = wallet;
          }
        }
      }
      Logger.success('getWalletByAddress success: $result');

      if (result == null) {
        throw Exception('Failed to get wallet detail by address');
      }

      return result;
    } catch (error) {
      Logger.error('getWalletByAddress error: $error');

      rethrow;
    }
  }

  @override
  int getWalletIndex({required WalletModel wallet}) {
    try {
      Logger.info('getWalletIndex params: wallet $wallet');

      // get wallet address
      final walletAddress = getWalletAddress(
        wallet: wallet,
        blockchain: BlockchainNetwork.tron,
      ).toLowerCase();

      final wallets = getWallets();
      final result = wallets.indexWhere((element) {
        // element wallet address
        final elementAddress = getWalletAddress(
          wallet: element,
          blockchain: BlockchainNetwork.tron,
        ).toLowerCase();

        return elementAddress == walletAddress;
      });

      Logger.success('getWalletIndex success: $result');

      return result;
    } catch (error) {
      Logger.error('getWalletIndex error: $error');

      rethrow;
    }
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
  Future<WalletModel> importWallet({block.Mnemonic? mnemonic}) async {
    try {
      final walletLength = getWallets().length;
      WalletModel wallet = const WalletModel();
      late String walletName;
      if (mnemonic == null) {
        throw Exception('Seed phrase empty');
      }

      wallet = await _importNonCustodialWallet(
        mnemonic: mnemonic,
      );
      final walletAddress = getWalletAddress(
        wallet: wallet,
      );

      walletName = 'Imported Wallet ${walletLength + 1}';

      // get app_version
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;

      // set wallet data
      wallet = wallet.copyWith(
        index: walletLength,
        name: walletName,
        status: "Imported",
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
        tikeetronUsername: '',
      );
      Logger.success('importWallet success: $wallet');

      return wallet;
    } catch (error) {
      Logger.error('importWallet error: $error');

      rethrow;
    }
  }

  Future<WalletModel> _importNonCustodialWallet({
    required block.Mnemonic mnemonic,
  }) async {
    try {
      // encrypt mnemonic
      final ecnryptedSeedPhrase = EncryptEngine.encryptData(
        mnemonic.toStr(),
      );
      WalletModel wallet = WalletModel(
        seed: ecnryptedSeedPhrase,
      );

      const blockchains = BlockchainConstant.defaultBlockchains;

      for (final blockchain in blockchains) {
        switch (blockchain) {
          case BlockchainNetwork.tron:
          case BlockchainNetwork.btt:
            final extracted = await locator<WalletUtils>().extractPrivateKeyFromSeed(
              mnemonic: mnemonic,
              blockchain: blockchain,
            );

            final publicKey = extracted.tronPrivateKey?.publicKey();
            final address = publicKey?.toAddress().toAddress();

            Logger.info('ADDRESS & BLOCKCHAIN TO BE IMPORTED -> $address + $blockchain');
            // validate wallet already exist
            final walletDetail = _getWalletDetailByAddress(
              address: address,
              blockchain: blockchain,
            );

            Logger.info('WALLETDETAIL -> $walletDetail');
            if (walletDetail != null) {
              throw Exception('wallet-already-exists');
            }

            // get addresses
            final addresses = wallet.addresses ?? [];

            // add new address
            addresses.add(
              WalletAddressModel(
                address: address,
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
      Logger.error('importNonCustodialWallet error: $error');

      if (error.errorMessage == 'wallet-already-exists') {
        throw 'Wallet already exists';
      } else {
        throw 'Invalid seed phrase, please input correctly';
      }
    }
  }

  WalletModel? _getWalletDetailByAddress({
    required String? address,
    BlockchainNetwork? blockchain,
  }) {
    final wallets = getWallets();

    final result = wallets.firstWhere((element) {
      // check if address is in token list
      for (final wallet in element.addresses!) {
        if (wallet.address!.toLowerCase() == address?.toLowerCase()) {
          if (wallet.blockchain != null) {
            if (wallet.blockchain == blockchain) {
              return true;
            }
          } else {
            return true;
          }
        }
      }

      return false;
    });

    return result;
  }

  @override
  Future<void> saveAddressToBackend({required String? walletAddress}) async {
    try {
      Logger.info("saveAddressToBackend: $walletAddress");

      // post wallet to backend
      await AppApi(version: 1).post('/address', body: {
        "address": walletAddress,
      });

      Logger.success("saveAddressToBackend success");
    } catch (error) {
      Logger.error('saveAddressToBackend error: $error');

      rethrow;
    }
  }

  @override
  Future<void> saveWallet({required WalletModel? wallet}) async {
    try {
      Logger.info("saveWallet: $wallet");

      if (wallet == null) {
        throw Exception("Failed to save wallet");
      }

      List<String> walletAddressList = [];
      final walletAddresses = wallet.addresses ?? [];

      for (final walletAddress in walletAddresses) {
        // get wallet address
        final address = walletAddress.address;
        if (address == null) {
          continue;
        }

        // if wallet address not in list, add to list
        if (!walletAddressList.contains(address)) {
          walletAddressList.add(address);
        }
      }

      for (final walletAddress in walletAddressList) {
        // post wallet to backend
        //TODO: Waiting for backend
        // await saveAddressToBackend(
        //   walletAddress: walletAddress,
        // );
      }

      // add to wallet repository
      await _walletLocalRepository.add(
        wallet.toJson(),
      );

      Logger.success("saveWallet success");
    } catch (error) {
      Logger.error('saveWallet error: $error');

      rethrow;
    }
  }

  @override
  Future<void> updateWalletData({required int walletIndex, required List keyValue}) async {
    try {
      Logger.info('updateWalletData: $walletIndex, $keyValue');

      Map<String, dynamic> wallet = getWallets()[walletIndex].toJson();

      if (keyValue.isNotEmpty) {
        // if keyValue is not empty, update wallet data
        for (final item in keyValue) {
          // set key value to wallet data
          wallet[item['key']] = item['value'];
        }

        // set lastUpdate to current time
        wallet['lastUpdate'] = DateTime.now();

        // update wallet data
        await _walletLocalRepository.putAt(walletIndex, wallet);
      }

      Logger.success('updateWalletData success');
    } catch (error) {
      Logger.error('updateWalletData error: $error');

      rethrow;
    }
  }
}
