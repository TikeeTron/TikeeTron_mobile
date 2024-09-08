import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/adapters/blockchain_network_adapter.dart';
import '../../../features/wallet/data/models/network_model.dart';
import '../currency_util.dart';
import '../encrypter/encrypter.dart';
import '../helpers/logger_helper.dart';
import '../network_list.dart';
import 'nft_blockchain_parsing.dart';

extension StringParsing on String {
  String get wcChains {
    _logger('this -> $this');

    String result = '';

    // get chain (eip155:137) from this String
    // eip155:137:0xDb773AA60D8f8C5012Ea0bF71FEc176169aa9287
    final chain = substring(0, lastIndexOf(':'));

    result = chain;

    _logger('result -> $result');

    return result;
  }

  void _logger(String message) {
    log(message, name: 'StringParsing');
  }

  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isContainsLetter {
    return RegExp(r'[a-zA-Z]').hasMatch(this);
  }

  bool get isContainsNumber {
    return RegExp(r'[0-9]').hasMatch(this);
  }

  bool get isContainsUpperCase {
    return RegExp(r'[A-Z]').hasMatch(this);
  }

  bool get isContainsLowerCase {
    return RegExp(r'[a-z]').hasMatch(this);
  }

  bool get isContainsSpecialCharacter {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this);
  }

  String get utf8Message {
    if (startsWith('0x')) {
      final List<int> decoded = hex.decode(
        substring(2),
      );
      return utf8.decode(decoded);
    }

    return this;
  }

  /// Get namespace from namespace:chainId
  ///
  /// Example: eip155:1
  ///
  /// Return: eip155
  String? get namespace {
    try {
      if (!contains(':')) {
        return this;
      }

      return split(':').first;
    } catch (error) {
      return null;
    }
  }

  /// Get chainId from namespace:chainId
  ///
  /// Example:
  /// - eip155:1 -> Return 1
  /// - solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp:HfGk1vNccG8ah1SgywQCTNmAYvXW3Z6dpvpzLZKLm1c6 -> Return 5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp
  String? get chainId {
    if (!contains(':')) {
      return toString();
    }

    final splits = split(':');

    if (splits.length < 2) {
      return toString();
    }

    return splits[1];
  }

  /// Get Wallet Address from given Namespace
  ///
  /// Examples:
  /// - solana:4sGjMW1sUnHzSxGspuhpqLDx6wiyjNtZ:HfGk1vNccG8ah1SgywQCTNmAYvXW3Z6dpvpzLZKLm1c6 return HfGk1vNccG8ah1SgywQCTNmAYvXW3Z6dpvpzLZKLm1c6
  String? get namespcaseWalletAddress {
    if (!contains(':')) {
      return null;
    }

    final splits = split(':');

    if (splits.length < 3) {
      return null;
    }

    return splits[2];
  }

  bool get isWCSessionUrl {
    return contains('relay-protocol') && contains('symKey');
  }

  bool get isWCRequestUrl {
    return contains('wc:') && contains('sessionTopic');
  }

  Uri get urlToWcUri {
    try {
      final String defaultUrl = this;
      late String url;

      _logger('urlToWcUri defaultUrl: $defaultUrl');

      if (Platform.isAndroid) {
        url = "wc:${defaultUrl.split('wc:')[1]}";
      } else {
        final newUri = Uri.decodeFull(defaultUrl.split('://')[1]);
        url = "wc:${newUri.toString().split('wc:')[1]}";
      }

      // change this string wc:3821a42a2e5f76c4f7916d9ddd7c645d8892409a5a4eadd973dc7e430cd095bc@0.0.0.2/?relay-protocol=irn&symKey=3b2f4ea205b0c96167e6ac498d2d898e6342623f673e52f618e2d4727e9226ab
      // with this
      // change 0.0.0.2 to 0.0.0.
      String prefix1 = "@";
      String suffix1 = "/";
      int startIndex = url.indexOf(prefix1);
      int endIndex = url.indexOf(suffix1);
      if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
        String subString = url.substring(startIndex + prefix1.length, endIndex);
        String newSubString = subString.replaceAll('0.0.0.', '');
        url = url.replaceRange(startIndex + prefix1.length, endIndex, newSubString);
      }

      // and change /? to ?
      String prefix2 = "/?";
      if (url.contains(prefix2)) {
        url = url.replaceAll(prefix2, "?");
      }

      final result = Uri.tryParse(url);
      Logger.success('urlToWcUri result: $result');

      if (result == null) {
        throw 'Invalid URI';
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// Get BlockchainNetwork from given address
  ///
  /// Ethereum address starts with 0x and has 46 characters
  ///
  /// Bitcoin address has 26-35 characters and starts with:
  /// - Mainnet address starts with 1 or 3
  /// - Testnet address starts with m, n, tb1 or 2
  BlockchainNetwork? get network {
    final addressLength = length;

    BlockchainNetwork? network;

    if (isNotEmpty) {
      final address = toLowerCase();
      if (addressLength == 42 && startsWith('0x')) {
        // Ethereum
        network = BlockchainNetwork.tron;
      } else if (addressLength >= 26 && addressLength <= 62) {
        // Bitcoin
        if (address.startsWith('1') || address.startsWith('3') || address.startsWith('bc1')) {
          // Mainnet
          network = BlockchainNetwork.btt;
        } else if (address.startsWith('m') || address.startsWith('n') || address.startsWith('tb1') || address.startsWith('2')) {
          // Testnet
          network = BlockchainNetwork.btt;
        }
      }
    }

    Logger.success('address result: ${network?.name}');

    return network;
  }

  /// Get KeychainKind from given address
  ///
  /// External keychain has more than 100 addresses
  ///
  /// Internal keychain has less than 100 addresses
  KeychainKind get keychain {
    KeychainKind? keychainKind;
    if (length >= 100) {
      keychainKind = KeychainKind.External;
    } else {
      keychainKind = KeychainKind.Internal;
    }

    log('keychain $this length $length is ${keychainKind.name}');

    return keychainKind;
  }

  /// Convert jwt in [String] to [Map]
  ///
  /// Example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ4ZWxsYXIiLCJleHAiOjE2MjQ0NjQ0NzAsImlhdCI6MTYyNDQ2Mzg3MCwiaXNzIjoiaHR0cHM6Ly9leGFtcGxlLmNvbSIsImp0aSI6IjEwMjM0NTY3ODkiLCJzdWIiOiJ4ZWxsYXIiLCJ
  ///
  /// Return: Map
  Map get jwtToMap {
    try {
      final parts = split('.');

      if (parts.length != 3) {
        throw 'Invalid Token';
      }

      final payload = parts[1];

      final normalized = base64.normalize(payload);

      final decoded = utf8.decode(base64.decode(normalized));

      final map = json.decode(decoded);

      return map;
    } catch (_) {
      rethrow;
    }
  }

  List<String> get encryptWalletToken {
    try {
      // get bytes size from string
      final bytesLength = utf8.encode(this).length;

      List<String> result = [];

      // split with max 200 bytes per string
      if (bytesLength > 200) {
        final splits = splitByLength(this, 200);

        for (final split in splits) {
          final encrypted = EncryptEngine.encryptData(split);

          result.add(encrypted);
        }
      } else {
        final encrypted = EncryptEngine.encryptData(this);

        result.add(encrypted);
      }

      return result;
    } catch (error) {
      _logger('encryptWalletToken: error -> $error');

      return [];
    }
  }

  ///Try to split and return null when error occured or splitted length is 1 which means no split occured
  List<String>? trySplit(String pattern) {
    try {
      final splitted = split(pattern);
      if (splitted.length == 1) {
        return null;
      }
      return splitted;
    } catch (error) {
      _logger('trySplit: error -> $error');
      return null;
    }
  }

  List<String> splitByLength(String str, int maxLength) {
    List<String> result = [];
    for (int i = 0; i < str.length; i += maxLength) {
      result.add(str.substring(i, i + maxLength < str.length ? i + maxLength : str.length));
    }
    return result;
  }

  String amountInWeiToToken({
    required int? decimals,
    int? fractionDigits,
  }) {
    try {
      String result = '';

      if (isNotEmpty) {
        final bigInt = BigInt.parse(this);
        final bigIntDecimals = BigInt.from(10).pow(decimals ?? 0);

        final bigIntResult = bigInt / bigIntDecimals;

        result = bigIntResult.toStringAsFixed(fractionDigits ?? 6);
      }

      return result;
    } catch (error) {
      _logger('amountInWeiToToken: error -> $error');
      rethrow;
    }
  }

  double? get weiToGwei {
    try {
      double result = 0;

      if (isNotEmpty) {
        final bigInt = BigInt.tryParse(this) ?? BigInt.zero;
        final bigIntDecimals = BigInt.from(10).pow(9);

        final bigIntResult = bigInt / bigIntDecimals;

        result = bigIntResult.toDouble();
      }

      return result;
    } catch (error) {
      _logger('weiToGwei: error -> $error');
      rethrow;
    }
  }

  BigInt? get gweiToWei {
    try {
      BigInt? result;

      if (isNotEmpty) {
        final double value = double.tryParse(this) ?? 0;

        final bigIntValue = BigInt.from((value * 1e9).toInt());
        result = bigIntValue;
      }

      return result;
    } catch (error) {
      _logger('gweiToWei: error -> $error');
      rethrow;
    }
  }

  /// Check if given token symbol is native token
  ///
  /// Token is native token, if token symbol is same with network symbol
  ///
  /// Example:
  /// - Token with symbol ETH in Ethereum network is native token
  bool isNativeToken({
    required String networkSymbol,
  }) {
    try {
      bool result = false;

      if (isNotEmpty && networkSymbol.isNotEmpty) {
        final tokenName = toLowerCase();
        final networkSymbolLowerCase = networkSymbol.toLowerCase();

        if (tokenName == networkSymbolLowerCase) {
          result = true;
        }
      }

      return result;
    } catch (error) {
      _logger('isNativeToken: error -> $error');
      rethrow;
    }
  }

  double? get toDouble {
    try {
      double? result;

      if (isNotEmpty) {
        result = double.tryParse(replaceAll(CurrencyUtils().getDecimalSeparator(), '.').replaceAll(',', '.')) ?? 0.0;
      }

      return result;
    } catch (error) {
      _logger('toDouble: error -> $error');
      rethrow;
    }
  }

  /// Get amount from given string
  ///
  /// Example:
  /// - BC1QZE54VVSJ2QCHADX9XJZS7D6FTM7P7LE0W6KVMM?amount=0.00127086&pj=https
  ///
  /// Return: 0.00127086
  String? get amount {
    try {
      Logger.info('amount: this -> $this');

      String? result;

      if (isNotEmpty) {
        final splits = split('?');

        if (splits.length > 1) {
          final params = splits[1].split('&');

          for (final param in params) {
            final keyValue = param.split('=');

            if (keyValue.length > 1) {
              final key = keyValue[0];
              final value = keyValue[1];

              if (key == 'amount') {
                result = value;
                break;
              }
            }
          }
        }
      }

      Logger.success('amount: result -> $result');

      return result;
    } catch (error) {
      Logger.error('amount: error -> $error');

      rethrow;
    }
  }

  /// Get wallet address from given string
  ///
  /// Example:
  /// - address=BC1QZE54VVSJ2QCHADX9XJZS7D6FTM7P7LE0W6KVMM
  /// - BC1QZE54VVSJ2QCHADX9XJZS7D6FTM7P7LE0W6KVMM:0.00127086
  /// - BC1QZE54VVSJ2QCHADX9XJZS7D6FTM7P7LE0W6KVMM?amount=0.00127086&pj=https
  ///
  /// Return: BC1QZE54VVSJ2QCHADX9XJZS7D6FTM7P7LE0W6KVMM
  String? get address {
    try {
      _logger('address: this -> $this');
      String? result;

      if (isNotEmpty) {
        // check is given string is address or contains address
        final addressNetwork = network;
        if (addressNetwork != null) {
          // given string is address
          result = this;
        } else {
          // given string maybe contains address
          if (contains('address=')) {
            final splits = split('address=');
            for (final split in splits) {
              final addressNetwork = split.network;
              if (addressNetwork != null) {
                result = split;
                break;
              }
            }
          } else if (contains(':')) {
            final splits = split(':');
            for (final split in splits) {
              final addressNetwork = split.network;
              if (addressNetwork != null) {
                result = split;
                break;
              }
            }
          } else if (contains('?')) {
            final splits = split('?');
            for (final split in splits) {
              final addressNetwork = split.network;
              if (addressNetwork != null) {
                result = split;
                break;
              }
            }
          } else {
            result = this;
          }
        }
      }

      _logger('address: result -> $result');

      return result;
    } catch (error) {
      _logger('address: error -> $error');
      rethrow;
    }
  }

  /// Convert given string to Uri
  ///
  /// Example:
  /// - https://www.google.com
  ///
  /// Return: Uri https://www.google.com
  Uri get toUri {
    try {
      _logger('toUri: this -> $this');
      Uri? result;

      if (isNotEmpty) {
        result = Uri.tryParse(this);
      }

      _logger('toUri: result -> $result');

      if (result == null) {
        throw 'Invalid URI';
      }

      return result;
    } catch (error) {
      _logger('toUri: error -> $error');

      rethrow;
    }
  }

  String toCapitalize() {
    if (length < 2) return this;

    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toCapitalizes() {
    if (length < 2) return this;
    if (split(' ').length < 2) return toCapitalize();

    final List<String> values = split(' ');
    String result = "";

    for (String val in values) {
      if (val.length > 1) {
        result += "${val[0].toUpperCase()}${val.substring(1).toLowerCase()} ";
      } else {
        result += "$val ";
      }
    }

    return result;
  }

  String get toGithubAssetUrl {
    Logger.info('toGithubAssetUrl params: this $this');

    String? result;

    if (isNotEmpty) {
      result = 'https://raw.githubusercontent.com/Xellar-Protocol/xellar-assets/master/assets/$this/logo.png';
    } else {
      result = 'https://raw.githubusercontent.com/Xellar-Protocol/xellar-assets/master/mainlogo.jpg';
    }
    Logger.success('toGithubAssetUrl result $result');

    return result;
  }

  /// Convert given string to file
  ///
  /// Example: /storage/emulated/0/Android/data/com.example.xellar/files/1624346168.png
  ///
  /// Return: File
  Future<File?> get toFile async {
    try {
      Logger.info('toFile params: this $this');

      File? result;
      if (isNotEmpty) {
        result = await File(this).create(recursive: true);
      }

      Logger.success('toFile result $result');

      return result;
    } catch (error) {
      Logger.error('toFile error $error');

      rethrow;
    }
  }

  /// Convert given url to file
  ///
  /// Example: https://raw.githubusercontent.com/Xellar-Protocol/xellar-assets/master/assets/xellar/logo.png
  ///
  /// Return: File
  Future<File?> get urlToFile async {
    try {
      Logger.info('urlToFile params: this $this');

      File? result;
      if (isNotEmpty) {
        // generate random number.
        var rng = math.Random();

        // get temporary directory of device.
        Directory tempDir = await getTemporaryDirectory();

        // get temporary path from temporary directory.
        String tempPath = tempDir.path;

        // create a new file in temporary path with random file name.
        result = File('$tempPath${rng.nextInt(100)}.png');

        // call http.get method and pass imageurl into it to get response.
        http.Response response = await http.get(Uri.parse(this));

        // write bodybytes received in response to file.
        await result.writeAsBytes(response.bodyBytes);
      }
      Logger.success('urlToFile result $result');

      return result;
    } catch (error) {
      Logger.error('urlToFile error $error');

      rethrow;
    }
  }

  String? txHashToUrl({
    required BlockchainNetwork? blockchain,
    required String? explorerUrl,
  }) {
    Logger.info('txHashToUrl params: this $this, blockchain $blockchain, explorerUrl $explorerUrl');

    String? result;

    if (isNotEmpty && blockchain != null && explorerUrl != null) {
      switch (blockchain) {
        case BlockchainNetwork.btt:
        case BlockchainNetwork.tron:
          result = "$explorerUrl/tx/$this";
          break;
      }
    }

    Logger.success('txHashToUrl result $result');

    return result;
  }

  /// Convert given string to initials
  ///
  /// Example: John Doe
  ///
  /// Return: JD
  String textToInitials({
    int? maxLength,
  }) {
    // Logger.info('textToInitials params: this $this, maxLength $maxLength');

    String result = '';

    maxLength ??= 2;

    if (isNotEmpty) {
      final splits = split(' ');

      for (final split in splits) {
        if (split.isNotEmpty) {
          result += split[0].toUpperCase();
        }

        if (result.length >= maxLength) {
          break;
        }
      }
    }

    // Logger.success('textToInitials result $result');

    return result;
  }

  /// Get wallet address from given account in namespace
  ///
  /// Example:
  /// - eip155:1:0x1234567890abcdef1234567890abcdef12345678
  ///
  /// Return: 0x1234567890abcdef1234567890abcdef12345678
  String? get wcAccountAddress {
    // Logger.info('wcAccountAddress params: this $this');

    String? result;

    if (isNotEmpty) {
      final splits = split(':');

      if (splits.length > 1) {
        result = splits[2];
      }
    }

    // Logger.success('wcAccountAddress result $result');

    return result;
  }

  bool get isSvgImage {
    // Logger.info('isSvgImage params: this $this');

    bool result = false;

    if (isNotEmpty) {
      result = endsWith('.svg');
    }

    // Logger.success('isSvgImage result $result');

    return result;
  }

  bool get isNetworkImage {
    // Logger.info('isNetworkImage params: this $this');

    bool result = false;

    if (isNotEmpty) {
      result = startsWith('http') || startsWith('https');
    }

    // Logger.success('isNetworkImage result $result');

    return result;
  }

  /// Remove coma and dot from given string
  ///
  /// Params:
  /// - isRemoveAfterComaAndDot: remove after coma and dot
  ///
  /// Example:
  /// - 1,000000
  /// - 1000.000
  /// - 1000.000 & isRemoveAfterComaAndDot: true
  ///
  /// Return:
  /// - 1000000
  /// - 1000000
  /// - 1000
  String removeComaAndDot({
    bool? isRemoveAfterComaAndDot,
  }) {
    Logger.info('removeComa params: this $this');

    String result = '';

    if (isNotEmpty) {
      if (isRemoveAfterComaAndDot == true) {
        // check if string contains coma
        final isContainsComa = contains(',');

        if (isContainsComa) {
          // remove coma and after
          final splits = split(',');
          if (splits.length > 1) {
            result = splits.first;
          } else {
            result = this;
          }
        } else {
          // check if string contains dot
          final isContainsDot = contains('.');

          if (isContainsDot) {
            // remove dot and after
            final splits = split('.');
            if (splits.length > 1) {
              result = splits.first;
            } else {
              result = this;
            }
          } else {
            result = this;
          }
        }
      } else {
        result = replaceAll(',', '').replaceAll('.', '');
      }
    }

    Logger.success('removeComa result $result');

    return result;
  }

  /// Format given String to DateTime
  ///
  /// Example: 2021-07-01T00:00:00.000Z
  ///
  /// Return: DateTime
  DateTime? get toDateTimeTransaction {
    try {
      Logger.info('toDateTimeTransaction params: this $this');

      DateTime? result;

      if (isNotEmpty) {
        result = DateFormat('MMMM dd yyyy, hh:mm a').parse(this);
      }

      Logger.success('toDateTimeTransaction result $result');

      return result;
    } catch (error) {
      Logger.error('toDateTimeTransaction error $error');

      return null;
    }
  }

  String? tokenAddressToUrl({
    required BlockchainNetwork? blockchain,
    required String? explorerUrl,
  }) {
    Logger.info('tokenAddressToUrl params: this $this, blockchain $blockchain, '
        'explorerUrl $explorerUrl');

    String? result;

    if (isNotEmpty && blockchain != null && explorerUrl != null) {
      switch (blockchain) {
        case BlockchainNetwork.tron:
        case BlockchainNetwork.btt:
          result = "$explorerUrl/token/$this";

          break;
      }
    }

    Logger.success('tokenAddressToUrl result $result');

    return result;
  }

  NftBlockchain? get toNftBlockchain {
    try {
      Logger.info('toNftBlockchain params: this $this');

      NftBlockchain? result;

      if (isNotEmpty) {
        final blockchain = toLowerCase();

        result = NftBlockchain.values.firstWhereOrNull(
          (element) => element.title.toLowerCase() == blockchain,
        );
      }

      Logger.success('toNftBlockchain result $result');

      return result;
    } catch (error) {
      Logger.error('toNftBlockchain error $error');

      return null;
    }
  }

  bool get isNumeric {
    if (isEmpty) {
      return false;
    }

    return double.tryParse(this) != null;
  }

  bool isNativePlatform({
    bool? isNative,
  }) {
    try {
      // Logger.info('isNativePlatform params: this $this');

      bool result = false;

      if (isNotEmpty) {
        if (toLowerCase() == 'native') {
          result = true;
        } else if (toLowerCase().startsWith('native-') && isNative == true) {
          result = true;
        }
      }

      //Logger.success('isNativePlatform result: $result');

      return result;
    } catch (error) {
      Logger.error('isNativePlatform error: $error');

      return false;
    }
  }

  BlockchainNetwork? get networkNameToBlockchain {
    try {
      Logger.info('networkNameToBlockchain params: this $this');

      BlockchainNetwork? result;

      if (isNotEmpty) {
        final network = toCapitalize();

        final networkMap = NetworkList.findNetworkByName(network);
        final networkDetail = NetworkModel.fromJson(networkMap);

        result = networkDetail.blockchain;
      }

      Logger.success('networkNameToBlockchain result: $result');

      return result;
    } catch (error) {
      Logger.error('networkNameToBlockchain error: $error');

      return null;
    }
  }

  /// Check if given string is same with other value
  ///
  /// Example:
  /// - 'native'.isSame('native') return true
  bool isSame(
    String otherValue,
  ) {
    try {
      Logger.info('isSame params: this $this, otherValue $otherValue');

      bool result = false;

      if (isNotEmpty && otherValue.isNotEmpty) {
        result = toLowerCase() == otherValue.toLowerCase();
      }

      Logger.success('isSame result: $result');

      return result;
    } catch (error) {
      Logger.error('isSame error: $error');

      return false;
    }
  }
}
