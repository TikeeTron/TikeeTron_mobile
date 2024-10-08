import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/utils/encrypter/encrypter.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../../core/core.dart';
import '../../../../../core/injector/injector.dart';
import '../../../../wallet/data/repositories/source/local/account_local_repository.dart';

part 'pin_state.dart';

@LazySingleton()
class PinCubit extends Cubit<PinState> {
  PinCubit() : super(PinInitial());

  void showPin({
    dynamic passedData,
    bool noCancel = false,
    bool isSetBiometric = false,
    bool initShowBiometric = false,
  }) {
    final AccountLocalRepository accountRepository = AccountLocalRepository();
    final useAppLock = accountRepository.get(AccountLocalRepository.appLockKey) ?? isSetBiometric;
    emit(ShowPin(
      passedData: passedData,
      noCancel: noCancel,
      isSetBiometric: useAppLock,
      initShowBiometric: useAppLock,
    ));
  }

  String decryptSeedOrKeyWithPin(
    String decryptedData,
    String pin,
  ) {
    Logger.info('decryptSeedOrKeyWithPin params: $decryptedData, $pin');

    final result = EncryptEngine.decryptAES(
      decryptedData,
      pin,
    );
    Logger.success('decryptSeedOrKeyWithPin result: $result');

    return result;
  }

  void correctPin({
    required String pin,
    dynamic passedData,
  }) {
    emit(CorrectPin(
      pin: pin,
      passedData: passedData,
    ));
  }

  void pinCreated({
    required String pin,
    dynamic passedData,
    dynamic encryptedData,
    String tagId = '',
  }) {
    emit(PinCreated(
      pin: pin,
      passedData: passedData,
      encryptedData: encryptedData,
      tagId: tagId,
    ));
  }

  void hidePin() {
    emit(HidePin());
  }

  void cancelPin() {
    emit(CancelPIN());
  }

  void errorPIN(String reason) {
    emit(ErrorPIN(reason: reason));
  }

  void checkLocalAuth() {
    final AccountLocalRepository accountRepository = AccountLocalRepository();
    final useAppLock = accountRepository.get(AccountLocalRepository.appLockKey) ?? false;
    emit(ShowPin(
      passedData: null,
      noCancel: true,
      initShowBiometric: useAppLock,
      isSetBiometric: useAppLock,
    ));
  }

  bool isCreatedPin({
    dynamic passedData,
  }) {
    // check if user has created pin
    final isCreated = locator<AccountLocalRepository>().getUserPin().isNotEmpty;

    if (!isCreated) {
      final context = navigationService.currentContext!;

      // input pin
      BlocProvider.of<PinCubit>(context).showPin(
        passedData: passedData,
      );

      // close dialog
      Navigator.of(context).pop();

      return false;
    }

    return true;
  }
}
