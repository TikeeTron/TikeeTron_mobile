import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import '../../../core/adapters/blockchain_network_adapter.dart';
import '../encrypter/encrypter.dart';

extension DynamicParsing on dynamic {
  /// Convert dynamic transaction hash to [BlockchainNetwork]
  ///
  /// Example: 0x0f5d2fb29fb7d3cfee444a200298f468908cc942
  ///
  /// Return: BlockchainNetwork.evm
  BlockchainNetwork get txHashToNetwork {
    BlockchainNetwork? network;

    if (network is String) {
      if ((this as String).startsWith('0x')) {
        network = BlockchainNetwork.tron;
      } else {
        network = BlockchainNetwork.btt;
      }
    }
    // Set dafult network type
    network ??= BlockchainNetwork.tron;

    return network;
  }

  String? get privateKeyDecrypt {
    try {
      String? result;

      if (this is String) {
        if ((this as String).contains(' ')) {
          // has encrypted
          result = this;
        } else {
          result = EncryptEngine.decryptData(this);
        }
      } else if (this is List<String>) {
        final List<String> decryptedList = [];

        for (final item in this) {
          final decrypted = EncryptEngine.decryptData(item);
          decryptedList.add(decrypted);
        }

        result = decryptedList.join('');
      }

      return result;
    } catch (e) {
      return null;
    }
  }

  Color get txStatusToColor {
    Color color = Colors.grey;

    if (this is String) {
      switch (this) {
        case 'pending':
          color = Colors.yellow;
          break;
        case 'success':
          color = Colors.green;
          break;
        case 'failed':
          color = Colors.red;
          break;
        default:
          color = Colors.grey;
      }
    }

    return color;
  }

  /// Convert dynamic to double
  ///
  /// Example: "100"
  ///
  /// Return: 100.0
  double? get dynamicToDouble {
    try {
      //Logger.info('dynamicToDouble $this type $runtimeType');

      double? result;

      if (this is String) {
        result = double.tryParse(this);
      } else if (this is int) {
        result = (this as int).toDouble();
      } else if (this is double) {
        result = this;
      }

      //Logger.success('dynamicToDouble result $result');

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// Convert dynamic to int
  ///
  /// Example: "100"
  ///
  /// Return: 100
  int? get dynamicToInt {
    try {
      int? result;

      if (this is String) {
        result = int.tryParse(this);
      } else if (this is int) {
        result = this;
      } else if (this is double) {
        result = (this as double).toInt();
      }

      return result ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  String? get dynamicToString {
    try {
      String? result;

      if (this is String) {
        result = this;
      } else if (this is int) {
        result = (this as int).toString();
      } else if (this is double) {
        result = (this as double).toString();
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  String? get shortedWalletAddress {
    try {
      String? result;

      if (this is String) {
        final length = (this as String).length;

        if (length > 10) {
          final first = (this as String).substring(0, 5);
          final last = (this as String).substring(length - 5, length);
          result = '$first...$last';
        } else {
          result = this;
        }
      }

      return result;
    } catch (e) {
      return null;
    }
  }

  bool get isNullOrEmpty {
    bool result = false;

    if (this == null) {
      result = true;
    }

    if (this is String) {
      result = (this as String).isEmpty;
    }

    if (this is List) {
      result = (this as List).isEmpty;
    }

    return result;
  }

  BlockchainNetwork? get dynamicToBlockchain {
    try {
      BlockchainNetwork? network;

      if (this is BlockchainNetwork) {
        network = this;
      }

      return network;
    } catch (error) {
      return null;
    }
  }

  BigInt? get dynamicToBigInt {
    try {
      BigInt? result;

      if (this is BigInt) {
        result = this;
      } else if (this is String) {
        result = BigInt.tryParse(this);
      } else if (this is int) {
        result = BigInt.from(this);
      } else if (this is EtherAmount) {
        result = (this as EtherAmount).getInWei;
      }

      return result;
    } catch (error) {
      return null;
    }
  }
}
