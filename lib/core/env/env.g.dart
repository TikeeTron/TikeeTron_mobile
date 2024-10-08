// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// SecureDotEnvAnnotationGenerator
// **************************************************************************

class _$Env extends Env {
  const _$Env(this._encryptionKey, this._iv) : super._();

  final String _encryptionKey;
  final String _iv;
  static final Uint8List _encryptedValues = Uint8List.fromList([
    229,
    41,
    196,
    167,
    176,
    162,
    7,
    1,
    168,
    133,
    224,
    144,
    126,
    181,
    89,
    178,
    86,
    29,
    34,
    51,
    155,
    255,
    206,
    87,
    140,
    165,
    41,
    73,
    191,
    104,
    222,
    219,
    42,
    48,
    6,
    238,
    80,
    214,
    165,
    222,
    212,
    78,
    111,
    192,
    4,
    14,
    125,
    247,
    57,
    76,
    213,
    250,
    192,
    208,
    141,
    72,
    139,
    226,
    239,
    195,
    7,
    0,
    195,
    15,
    225,
    127,
    238,
    183,
    48,
    95,
    170,
    104,
    102,
    205,
    141,
    255,
    151,
    71,
    94,
    33,
    55,
    46,
    164,
    97,
    154,
    226,
    178,
    60,
    128,
    74,
    35,
    78,
    43,
    134,
    163,
    18,
    81,
    66,
    84,
    242,
    132,
    113,
    127,
    147,
    225,
    208,
    69,
    123,
    156,
    107,
    233,
    147,
    52,
    190,
    186,
    172,
    149,
    221,
    179,
    60,
    188,
    27,
    103,
    102,
    100,
    193,
    93,
    251
  ]);
  @override
  String get baseUrl => _get('BASE_URL');

  @override
  String get aiUrl => _get('AI_URL');

  T _get<T>(
    String key, {
    T Function(String)? fromString,
  }) {
    T _parseValue(String strValue) {
      if (T == String) {
        return (strValue) as T;
      } else if (T == int) {
        return int.parse(strValue) as T;
      } else if (T == double) {
        return double.parse(strValue) as T;
      } else if (T == bool) {
        return (strValue.toLowerCase() == 'true') as T;
      } else if (T == Enum || fromString != null) {
        if (fromString == null) {
          throw Exception('fromString is required for Enum');
        }

        return fromString(strValue.split('.').last);
      }

      throw Exception('Type ${T.toString()} not supported');
    }

    final encryptionKey = base64.decode(_encryptionKey.trim());
    final iv = base64.decode(_iv.trim());
    final decrypted =
        AESCBCEncryper.aesCbcDecrypt(encryptionKey, iv, _encryptedValues);
    final jsonMap = json.decode(decrypted) as Map<String, dynamic>;
    if (!jsonMap.containsKey(key)) {
      throw Exception('Key $key not found in .env file');
    }

    final encryptedValue = jsonMap[key] as String;
    final decryptedValue = AESCBCEncryper.aesCbcDecrypt(
      encryptionKey,
      iv,
      base64.decode(encryptedValue),
    );
    return _parseValue(decryptedValue);
  }
}
