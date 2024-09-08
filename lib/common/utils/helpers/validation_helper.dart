import 'package:form_validator/form_validator.dart';

class ValidationHelper {
  static String? Function(String?) required(
    String message,
  ) =>
      ValidationBuilder(
        requiredMessage: message,
      ).build();

  static final String? Function(String?) email = ValidationBuilder(
    requiredMessage: 'Email is required',
  )
      .maxLength(
        100,
        'Email is too long',
      )
      .regExp(
        RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ),
        'Email is not valid',
      )
      .build();

  static final String? Function(String?) password = ValidationBuilder(
    requiredMessage: 'Password is required',
  )
      .maxLength(
        50,
        'Password is too long',
      )
      .regExp(
        RegExp(
          r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$",
        ),
        'Password is not valid',
      )
      .build();

  static String? Function(String?) confirmPassword(String password) =>
      ValidationBuilder(
        requiredMessage: 'Confirm password is required',
      )
          .add((value) {
            if (value?.trim() != password.trim()) {
              return 'Password confirmation does not match';
            }
            return null;
          })
          .maxLength(
            50,
            'Confirm password is too long',
          )
          .regExp(
            RegExp(
              r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$",
            ),
            'Confirm password is not valid',
          )
          .build();
}
