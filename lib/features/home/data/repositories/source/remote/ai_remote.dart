import 'package:injectable/injectable.dart';

import '../../../../../../common/dio/api.config.dart';
import '../../../../../../common/error/exception.dart';
import '../../../../../../main.dart';

@LazySingleton()
class AiRemote {
  AiRemote();

  Future<String> askAi({required String question}) async {
    try {
      final result = await AppApi(
        baseUrl: env.aiUrl,
      ).post(
        '/ask',
        body: {
          'question': question,
        },
      );

      if (result == null) {
        throw const ServerException();
      }

      // if ((result as Map).containsKey('status')) {
      //   if (result['status'] != 200) {
      //     throw result['message'];
      //   }
      // } else if (result.containsKey('statusCode')) {
      //   if (result['statusCode'] != 200) {
      //     throw result['message'];
      //   }
      // }

      return result;
    } catch (error) {
      rethrow;
    }
  }
}
