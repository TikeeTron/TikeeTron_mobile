import 'package:injectable/injectable.dart';

import '../../../../../../core/app/app_repository.dart';

@LazySingleton()
class WalletLocalRepository {
  static WalletLocalRepository? _singleton;
  AppRepository? _appRepository;

  factory WalletLocalRepository() {
    _singleton ??= WalletLocalRepository._internal();

    return _singleton!;
  }

  static const String walletKey = 'walletV2';

  WalletLocalRepository._internal() {
    _appRepository = AppRepository('walletV2');
  }

  get<E>(E key) {
    return _appRepository!.get(key);
  }

  Future<void> save<E>(String key, E entries) async {
    await _appRepository!.put(key, entries);
  }

  Future<void> putAt<E>(int index, E value) async {
    await _appRepository!.putAt(index, value);
  }

  Future<void> delete(dynamic key) async {
    await _appRepository!.delete(key);
  }

  Future<void> deleteAt(int index) async {
    await _appRepository!.deleteAt(index);
  }

  Future<void> close() async {
    await _appRepository!.close();
  }

  Future<int> clear() async {
    return await _appRepository!.clear();
  }

  Future<int> add<E>(E value) async {
    return await _appRepository!.add(value);
  }

  List? getAll() {
    return _appRepository?.getAll().toList();
  }

  Iterable<dynamic> values() {
    return _appRepository!.getAll();
  }
}
