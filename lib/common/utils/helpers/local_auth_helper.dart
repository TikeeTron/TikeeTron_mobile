import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';

import '../utils.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> canAuthentication() async => await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate({bool biometricOnly = true, bool errorMessage = true}) async {
    try {
      if (!await canAuthentication()) return false;
      final result = await _auth.authenticate(
          localizedReason: "Please unlock to proceed",
          authMessages: const [
            AndroidAuthMessages(
              cancelButton: "Cancel",
              goToSettingsButton: "Settings",
            ),
            IOSAuthMessages(
              lockOut: "Please reenable your security features",
              cancelButton: "Cancel",
              goToSettingsButton: "Settings",
            ),
          ],
          options: AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            sensitiveTransaction: true,
            biometricOnly: biometricOnly,
          ));

      await Future.delayed(const Duration(milliseconds: 500));
      return result;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (!errorMessage) {
        return false;
      }

      if (e.code == auth_error.notAvailable || e.code == auth_error.notEnrolled) {
        toastHelper.showError('Please turn on extra security features under your phone settings');
      }
      return false;
    }
  }
}
