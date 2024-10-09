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
    23,
    60,
    123,
    232,
    221,
    54,
    134,
    211,
    232,
    151,
    181,
    93,
    189,
    118,
    114,
    85,
    20,
    23,
    221,
    72,
    152,
    233,
    157,
    208,
    26,
    166,
    18,
    2,
    147,
    69,
    41,
    80,
    112,
    111,
    28,
    205,
    147,
    189,
    143,
    160,
    132,
    189,
    76,
    32,
    83,
    44,
    51,
    60,
    212,
    167,
    162,
    85,
    22,
    4,
    56,
    247,
    215,
    88,
    95,
    229,
    1,
    68,
    183,
    64,
    205,
    33,
    98,
    167,
    193,
    161,
    237,
    228,
    183,
    164,
    42,
    139,
    73,
    108,
    182,
    140,
    0,
    44,
    162,
    23,
    35,
    122,
    204,
    204,
    4,
    228,
    75,
    186,
    205,
    231,
    69,
    65,
    190,
    83,
    253,
    78,
    201,
    152,
    215,
    93,
    123,
    208,
    56,
    90,
    200,
    111,
    97,
    113,
    15,
    101,
    189,
    122,
    118,
    147,
    71,
    249,
    111,
    207,
    157,
    183,
    149,
    205,
    20,
    121
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
