import '../../dio/dio_exception.dart';

extension ExceptionParsing on Exception {
  String get message {
    late String message;
    if (this is AppException) {
      message = (this as AppException).message;
    } else {
      message = toString();
    }

    if (message.contains('Exception: ')) {
      // remove 'Exception: '
      return message.replaceAll('Exception: ', '');
    } else if (message.contains('insufficient') && message.contains('funds')) {
      return 'Insufficient balance';
    }

    return message;
  }
}
