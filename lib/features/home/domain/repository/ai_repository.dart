import '../../data/model/response/ask_ai_response.dart';

abstract class AiRepository {
  Future<AskAiResponse> askAi({
    required String question,
    required String userAddress,
  });
}
