import 'package:injectable/injectable.dart';

import '../../../../../../core/app/app_repository.dart';

@LazySingleton()
class AccountLocalRepository {
  static AccountLocalRepository? _singleton;
  AppRepository? _appRepository;

  factory AccountLocalRepository() {
    _singleton ??= AccountLocalRepository._internal();

    return _singleton!;
  }

  AccountLocalRepository._internal() {
    _appRepository = AppRepository('account');
  }

  static const String appLockKey = 'applock';
  static const String activeWalletIndex = 'activeWalletIndex';
  static const String activeWallet = 'activeWallet';
  static const String topicProduct = 'product';
  static const String topicInsight = 'insight';
  static const String topicOffer = 'offer';
  static const String topicAll = 'all';
  static const String topicTestingNotification = 'testing-notification';
  static const String hideAllBalance = 'hide-all-balance';
  static const String hideZeroBalance = 'hide-zero-balance';
  static const String hideSmallBalance = 'hide-small-balance';
  static const String hideTestnet = 'hide-testnet';
  static const String currency = 'currency';
  static const String currencySymbol = 'currency_symbol';
  static const String themeMode = 'theme-mode';

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

  List? getValueInList() {
    return _appRepository?.getAll().toList();
  }

  Iterable<dynamic>? getAllValues() {
    return _appRepository?.getAll();
  }

  Iterable<dynamic>? getAllKeys() {
    return _appRepository?.getKeys();
  }

  bool hasToken() {
    final String? token = get('token');

    if (token != null && token.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<void> setIdUser(int idUser) async {
    await _appRepository!.put("idUser", idUser);
  }

  Future<void> setIdToken(String idToken) async {
    await _appRepository!.put("idToken", idToken);
  }

  Future<void> setToken(String token) async {
    await _appRepository!.put("token", token);
  }

  Future<void> setName(String name) async {
    await _appRepository!.put("name", name);
  }

  Future<void> setEmail(String email) async {
    await _appRepository!.put("email", email);
  }

  Future<void> setProfilePictureUrl(String profilePictureUrl) async {
    await _appRepository!.put("profilePictureUrl", profilePictureUrl);
  }

  Future<void> deleteToken() async {
    await _appRepository!.delete("token");
  }

  Future<void> deleteName() async {
    await _appRepository!.delete("name");
  }

  Future<void> deleteEmail() async {
    await _appRepository!.delete("email");
  }

  Future<void> deleteProfilePictureUrl() async {
    await _appRepository!.delete("profilePictureUrl");
  }

  String? getIdToken() {
    return get('idToken');
  }

  String? getToken() {
    return get('token');
  }

  int? getIdUser() {
    return get('idUser');
  }

  List<int> getUserPin() {
    return get('pin') ?? [];
  }

  String? getName() {
    return get('name');
  }

  String? getEmail() {
    return get('email');
  }

  String? getProfilePictureUrl() {
    return get('profilePictureUrl');
  }

  setUserPin(List<int> pin) async {
    await _appRepository!.put("pin", pin);
  }
}
