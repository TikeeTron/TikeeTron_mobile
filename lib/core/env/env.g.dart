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
    233,
    128,
    36,
    70,
    118,
    204,
    0,
    240,
    16,
    69,
    134,
    26,
    36,
    162,
    244,
    153,
    27,
    224,
    21,
    127,
    44,
    214,
    113,
    106,
    14,
    78,
    0,
    72,
    119,
    223,
    143,
    218,
    148,
    161,
    17,
    154,
    193,
    124,
    34,
    50,
    5,
    237,
    79,
    97,
    240,
    56,
    167,
    210,
    96,
    165,
    182,
    86,
    85,
    46,
    58,
    204,
    40,
    2,
    115,
    204,
    82,
    71,
    250,
    229,
    84,
    244,
    100,
    148,
    47,
    208,
    148,
    186,
    222,
    71,
    94,
    35,
    11,
    241,
    85,
    194,
    142,
    181,
    61,
    95,
    251,
    179,
    215,
    88,
    90,
    187,
    32,
    98,
    167,
    157,
    194,
    12,
    106,
    181,
    145,
    237,
    113,
    242,
    113,
    108,
    184,
    12,
    29,
    202,
    35,
    205,
    205,
    85,
    35,
    133,
    248,
    197,
    226,
    67,
    90,
    44,
    151,
    120,
    45,
    47,
    101,
    69,
    180,
    175
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
