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
    165,
    110,
    28,
    213,
    19,
    48,
    183,
    114,
    76,
    120,
    188,
    134,
    67,
    87,
    162,
    49,
    33,
    56,
    23,
    70,
    71,
    103,
    22,
    142,
    107,
    129,
    58,
    90,
    6,
    60,
    103,
    208,
    168,
    44,
    157,
    247,
    135,
    71,
    117,
    35,
    43,
    165,
    115,
    183,
    208,
    160,
    137,
    253,
    19,
    105,
    28,
    7,
    159,
    216,
    250,
    163,
    118,
    233,
    226,
    148,
    11,
    242,
    4,
    205,
    13,
    87,
    112,
    87,
    13,
    170,
    117,
    131,
    87,
    248,
    209,
    45,
    175,
    184,
    100,
    234,
    178,
    135,
    8,
    219,
    185,
    29,
    11,
    31,
    23,
    132,
    0,
    95,
    18,
    140,
    227,
    172,
    200,
    172,
    52,
    142,
    44,
    228,
    167,
    242,
    172,
    167,
    147,
    64,
    163,
    87,
    30,
    196,
    40,
    198,
    138,
    96,
    190,
    91,
    203,
    7,
    50,
    149,
    115,
    47,
    65,
    97,
    106,
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
