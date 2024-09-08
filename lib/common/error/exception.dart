import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable {
  final Object? code;
  final String? message;

  const CustomException({
    this.code,
    this.message,
  });

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}

class NetworkException extends CustomException {
  const NetworkException({
    super.code,
    super.message,
  });
}

class InsufficientBalanceException extends CustomException {
  const InsufficientBalanceException({
    super.code,
    super.message,
  });
}

class ServerException extends CustomException {
  const ServerException({
    super.code,
    super.message,
  });
}

class UserException extends CustomException {
  const UserException({
    super.code,
    super.message,
  });
}
