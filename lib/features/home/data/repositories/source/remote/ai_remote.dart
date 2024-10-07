import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/dio/api.config.dart';
import '../../../../../../common/error/exception.dart';
import '../../../model/response/ask_ai_response.dart';

@LazySingleton()
class AiRemote {
  AiRemote();

  Future<AskAiResponse> askAi({
    required String question,
    required String userAddress,
  }) async {
    try {
      final result = await AppApi(
        baseUrl: 'https://ai.tikeetron.cloud',
      ).post(
        '/ask',
        body: {
          'question': question,
        },
        options: Options(
          headers: {
            'user-address': userAddress,
          },
        ),
      );

      if (result == null) {
        throw const ServerException();
      }

      return AskAiResponse.fromJson(result);
    } catch (error) {
      rethrow;
    }
  }
}
