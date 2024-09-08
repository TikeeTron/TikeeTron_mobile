import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'core/adapters/blockchain_network_adapter.dart';
import 'core/adapters/token_type_adapter.dart';

@LazySingleton()
class HiveInitialization {
  Future<void> initHive() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BlockchainNetworkAdapter());
    }

    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TokenTypeAdapter());
    }

    const secureStorage = FlutterSecureStorage();

    // if key not exists return null
    final encryptionKeyString = await secureStorage.read(key: 'key');
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(key: 'key');
    final encryptionKeyUint8List = base64Url.decode(key!);

    // if old db exist without aes encryption, running migration function

    await Hive.openBox(
      'walletV2',
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );
    await Hive.openBox(
      'accountV2',
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );
  }
}
