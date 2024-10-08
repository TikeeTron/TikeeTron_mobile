part of 'pin_cubit.dart';

abstract class PinState {}

class PinInitial extends PinState {}

class ShowPin extends PinState {
  final dynamic passedData;
  final bool noCancel;
  final bool? isSetBiometric;
  final bool? initShowBiometric;

  ShowPin({
    this.passedData,
    required this.noCancel,
    this.isSetBiometric,
    this.initShowBiometric,
  });
}

class HidePin extends PinState {}

class CorrectPin extends PinState {
  final String pin;
  final dynamic passedData;
  CorrectPin({required this.pin, this.passedData});
}

class PinCreated extends PinState {
  final String pin;
  final dynamic passedData;
  final dynamic encryptedData;

  final String tagId;
  PinCreated({required this.pin, this.passedData, this.encryptedData, this.tagId = ''});
}

class IncorrectPin extends PinState {}

class CancelPIN extends PinState {}

class ErrorPIN extends PinState {
  final String reason;
  ErrorPIN({required this.reason});
}
