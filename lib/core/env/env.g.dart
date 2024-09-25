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
    164,
    69,
    151,
    90,
    240,
    160,
    82,
    166,
    190,
    196,
    240,
    129,
    172,
    170,
    144,
    10,
    214,
    57,
    109,
    178,
    106,
    207,
    196,
    48,
    115,
    17,
    217,
    98,
    208,
    91,
    186,
    243,
    149,
    190,
    81,
    243,
    150,
    98,
    178,
    153,
    127,
    187,
    69,
    223,
    148,
    131,
    21,
    121,
    62,
    202,
    45,
    15,
    248,
    36,
    151,
    158,
    239,
    119,
    242,
    109,
    238,
    81,
    106,
    226,
    91,
    61,
    128,
    228,
    207,
    196,
    236,
    152,
    190,
    194,
    220,
    145,
    214,
    27,
    151,
    29,
    33,
    177,
    160,
    41,
    57,
    223,
    67,
    221,
    147,
    190,
    40,
    72,
    88,
    183,
    204,
    213,
    156,
    30,
    19,
    138,
    133,
    125,
    200,
    161,
    232,
    240,
    175,
    186,
    85,
    80,
    233,
    191,
    245,
    9,
    203,
    11,
    137,
    184,
    86,
    244,
    157,
    138,
    243,
    243,
    107,
    236,
    206,
    55
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
