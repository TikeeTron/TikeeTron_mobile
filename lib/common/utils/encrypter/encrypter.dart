import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' as printing;
import 'package:pointycastle/asymmetric/api.dart';

import '../helpers/logger_helper.dart';
import 'keystore.dart';

class EncryptEngine {
  static String encryptData(String data) {
    try {
      RSAKeyParser keyParser = RSAKeyParser();
      RSAAsymmetricKey privateKeyParser = keyParser.parse(KeyStore.privkey);
      RSAAsymmetricKey publicKeyParser = keyParser.parse(KeyStore.pubkey);
      final publicKey = RSAPublicKey(
        publicKeyParser.modulus!,
        publicKeyParser.exponent!,
      );

      String? encryptedData;

      if (privateKeyParser is RSAPrivateKey) {
        final privKey = RSAPrivateKey(
          privateKeyParser.modulus!,
          privateKeyParser.exponent!,
          privateKeyParser.p,
          privateKeyParser.q,
        );

        final encrypter = Encrypter(RSA(
          publicKey: publicKey,
          privateKey: privKey,
        ));

        final encrypted = encrypter.encrypt(data);
        encryptedData = encrypted.base64;
      }
      if (encryptedData == null) {
        throw Exception('Failed to encrypt data');
      }

      return encryptedData;
    } catch (error) {
      Logger.error("encryptData error: $error");

      rethrow;
    }
  }

  static String encryptAES(String data, String pin) {
    final key = Key.fromUtf8("${KeyStore.aesWrapperKey}$pin");
    final iv = IV.allZerosOfLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(data, iv: iv);

    final result = encrypted.base64;

    return result;
  }

  static String decryptAES(String decryptedData, String pin) {
    try {
      final key = Key.fromUtf8("${KeyStore.aesWrapperKey}$pin");

      final iv = IV.allZerosOfLength(16);

      final encrypter = Encrypter(AES(key));

      final decrypted = encrypter.decrypt(Encrypted.fromBase64(decryptedData), iv: iv);

      return decrypted;
    } catch (e) {
      printing.debugPrint("not valid pin");
      return '';
    }
  }

  static String decryptData(data) {
    try {
      RSAKeyParser keyParser = RSAKeyParser();
      RSAAsymmetricKey privateKeyParser = keyParser.parse(KeyStore.privkey);
      RSAAsymmetricKey publicKeyParser = keyParser.parse(KeyStore.pubkey);
      final publicKey = RSAPublicKey(
        publicKeyParser.modulus!,
        publicKeyParser.exponent!,
      );

      String? decryptedData;

      if (data is String && data.contains(" ")) {
        // if data is a string and contains a space, it means data has been de
        decryptedData = data;
      } else {
        if (privateKeyParser is RSAPrivateKey) {
          final privKey = RSAPrivateKey(
            privateKeyParser.modulus!,
            privateKeyParser.exponent!,
            privateKeyParser.p,
            privateKeyParser.q,
          );

          final encrypter = Encrypter(RSA(
            publicKey: publicKey,
            privateKey: privKey,
          ));

          final decrypted = encrypter.decrypt(Encrypted.fromBase64(data));

          decryptedData = decrypted.toString();
        }
      }

      if (decryptedData == null) {
        throw Exception('Failed to decrypt data');
      }

      return decryptedData;
    } catch (error) {
      Logger.error("decryptData error: $error");

      rethrow;
    }
  }
}
