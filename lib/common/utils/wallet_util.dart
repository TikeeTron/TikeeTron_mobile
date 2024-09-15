import 'dart:convert';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip39/bip39.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:web3dart/web3dart.dart';

import '../../core/adapters/blockchain_network_adapter.dart';
import '../../features/wallet/data/model/wallet_model.dart';
import '../../features/blockchain/data/models/private_key_model.dart';
import 'extensions/string_parsing.dart';
import 'helpers/logger_helper.dart';
import 'network_list.dart';

@LazySingleton()
class WalletUtils {
  Uint8List mnemonicWithPhrase(Map<Object, String> map) {
    return mnemonicToSeed(map['mne'].toString(), passphrase: map['phrase'].toString());
  }

  Future<PrivateKeyModel> extractPrivateKeyFromSeed(
    String mne,
    String? phrase, {
    required BlockchainNetwork blockchain,
  }) async {
    try {
      Logger.info('extractPrivateKeyFromSeed params: mne $mne, phrase $phrase, blockchain $blockchain');

      EthPrivateKey? ethPrivateKey;
      String? privateKey;
      DescriptorSecretKey? descriptorSecretKey;

      switch (blockchain) {
        case BlockchainNetwork.tron:
        case BlockchainNetwork.btt:
          Map<Object, String> datas = {"mne": mne, "phrase": phrase ?? ''};

          final root = bip32.BIP32.fromSeed(await foundation.compute(mnemonicWithPhrase, datas));
          final key1 = root.derivePath("m/44'/60'/0'/0/0");

          privateKey = hex.encode(key1.privateKey!.cast());
          ethPrivateKey = EthPrivateKey.fromHex(privateKey);
          break;
      }
      Logger.success('extractPrivateKeyFromSeed success: ethPrivateKey $ethPrivateKey, privateKey $privateKey, descriptorSecretKey $descriptorSecretKey');

      return PrivateKeyModel(
        ethPrivateKey: ethPrivateKey,
        privateKey: privateKey,
        descriptorSecretKey: descriptorSecretKey,
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
