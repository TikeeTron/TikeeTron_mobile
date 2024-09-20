import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip39/bip39.dart';
import 'package:blockchain_utils/blockchain_utils.dart' as block;
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:on_chain/on_chain.dart';
import 'package:web3dart/web3dart.dart';

import '../../core/adapters/blockchain_network_adapter.dart';
import '../../features/blockchain/data/models/private_key_model.dart';
import '../../features/wallet/data/model/wallet_model.dart';
import 'extensions/string_parsing.dart';
import 'helpers/logger_helper.dart';
import 'network_list.dart';

@LazySingleton()
class WalletUtils {
  Uint8List mnemonicWithPhrase(Map<Object, String> map) {
    return mnemonicToSeed(map['mne'].toString(), passphrase: map['phrase'].toString());
  }

  Future<PrivateKeyModel> extractPrivateKeyFromSeed({
    required block.Mnemonic mnemonic,
    required BlockchainNetwork blockchain,
  }) async {
    try {
      Logger.info('extractPrivateKeyFromSeed params: mne $mnemonic, blockchain $blockchain');

      TronPrivateKey? tronPrivateKey;
      String? privateKey;
      final seed = block.Bip39SeedGenerator(mnemonic).generate();
      switch (blockchain) {
        case BlockchainNetwork.tron:
        case BlockchainNetwork.btt:
          final bip44 = block.Bip44.fromSeed(seed, block.Bip44Coins.tron);
          final childKey = bip44.deriveDefaultPath;
          final tronPrivKey = TronPrivateKey.fromBytes(childKey.privateKey.raw);

// block.Bip44.fromSeed(seed, block.Bip44Coins.tron);
          tronPrivateKey = tronPrivKey;
          privateKey = tronPrivKey.toHex();
          break;
      }
      Logger.success('extractPrivateKeyFromSeed success: ethPrivateKey $tronPrivateKey, privateKey $privateKey,');

      return PrivateKeyModel(
        tronPrivateKey: tronPrivateKey,
        privateKey: privateKey,
      );
    } catch (error) {
      Logger.error('extractPrivateKeyFromSeed error: $error');

      rethrow;
    }
  }

  bool validateSeed(String phrase) {
    var isValid = bip39.validateMnemonic(phrase.trim());
    if (isValid) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidAddress(String address) {
    try {
      // check network by address
      final blockchain = address.network;
      bool result = false;

      if (blockchain == BlockchainNetwork.tron) {
        if (EthereumAddress.fromHex(address).hexEip55.isNotEmpty) {
          result = true;
        }
      } else if (blockchain == BlockchainNetwork.btt) {
        result = true;
      }

      return result;
    } catch (e) {
      return false;
    }
  }

  String shortAddress({required String address}) {
    try {
      return "${address.substring(0, 5)}... ${address.substring(address.length - 3, address.length)}";
    } catch (e) {
      return address;
    }
  }

  bool compare(WalletModel? activeWallet, WalletModel? wallet) => md5.convert(utf8.encode(activeWallet.toString())) == md5.convert(utf8.encode(wallet.toString()));

  static Map<Object, dynamic> nftFormat({
    required String address,
    required String networkId,
    required int tokenId,
    required String url,
    String name = "",
    String description = "",
    List<dynamic> attributes = const [],
    required bool isERC721,
    required int amount,
  }) {
    return {
      "address": EthereumAddress.fromHex(address).hexEip55,
      "network_id": networkId,
      "chainId": NetworkList.findChainIDByNetworkID(networkId),
      "tokenId": tokenId,
      "url": url,
      "name": name,
      "description": description,
      "attributes": attributes,
      "amount": amount,
      "isERC721": isERC721,
    };
  }
}
