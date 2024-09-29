// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// SecureDotEnvAnnotationGenerator
// **************************************************************************

class _$Env extends Env {
  const _$Env() : super._();

  static const String _encryptedValues =
      'eyJCQVNFX1VSTCI6ImFIUjBjSE02THk5aGNHa3VlR1ZzYkdGeUxtTnYiLCJBSV9VUkwiOiJhSFIwY0hNNkx5OWhhUzUwYVd0bFpYUnliMjR1YkdGaGJTNXRlUzVwWkE9PSJ9';
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

    final bytes = base64.decode(_encryptedValues);
    final stringDecoded = String.fromCharCodes(bytes);
    final jsonMap = json.decode(stringDecoded) as Map<String, dynamic>;
    if (!jsonMap.containsKey(key)) {
      throw Exception('Key $key not found in .env file');
    }
    final encryptedValue = jsonMap[key] as String;
    final decryptedValue = base64.decode(encryptedValue);
    final stringValue = String.fromCharCodes(decryptedValue);
    return _parseValue(stringValue);
  }
}
