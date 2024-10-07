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
    151,
    230,
    225,
    97,
    178,
    73,
    243,
    133,
    65,
    49,
    171,
    199,
    152,
    86,
    73,
    3,
    22,
    172,
    36,
    92,
    234,
    41,
    169,
    63,
    114,
    29,
    157,
    240,
    85,
    22,
    146,
    62,
    147,
    172,
    80,
    149,
    223,
    251,
    2,
    252,
    219,
    35,
    102,
    188,
    117,
    182,
    145,
    85,
    105,
    114,
    160,
    160,
    45,
    128,
    122,
    146,
    20,
    180,
    113,
    211,
    190,
    103,
    199,
    55,
    171,
    38,
    135,
    206,
    209,
    29,
    123,
    146,
    209,
    229,
    190,
    239,
    203,
    16,
    248,
    179,
    20,
    192,
    127,
    208,
    170,
    132,
    244,
    81,
    218,
    190,
    213,
    15,
    201,
    66,
    178,
    68,
    202,
    181,
    169,
    57,
    109,
    95,
    239,
    45,
    90,
    9,
    27,
    179,
    69,
    38,
    39,
    88,
    245,
    240,
    164,
    233,
    220,
    183,
    181,
    37,
    202,
    163,
    157,
    95,
    178,
    9,
    90,
    204
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
