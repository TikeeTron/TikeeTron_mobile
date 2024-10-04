import 'package:injectable/injectable.dart';

import '../../../../../../core/app/app_repository.dart';

@LazySingleton()
class TransactionLocalRepository {
  static TransactionLocalRepository? _singleton;
  AppRepository? _appRepository;

  factory TransactionLocalRepository() {
    _singleton ??= TransactionLocalRepository._internal();

    return _singleton!;
  }

  TransactionLocalRepository._internal() {
    _appRepository = AppRepository('transaction');
  }

  get<E>(E key) {
    return _appRepository!.get(key);
  }

  Future<void> save<E>(String key, E entries) async {
    await _appRepository!.put(key, entries);
  }

  Future<void> delete(dynamic key) async {
    await _appRepository!.delete(key);
  }

  Future<void> close() async {
    await _appRepository!.close();
  }

  Future<int> clear() async {
    return await _appRepository!.clear();
  }

  List? getAll() {
    return _appRepository?.getAll().toList();
  }

  Future<void> deleteAt(int index) async {
    return await _appRepository!.deleteAt(index);
  }

  Future<int> add<E>(E value) async {
    return await _appRepository!.add(value);
  }
}
