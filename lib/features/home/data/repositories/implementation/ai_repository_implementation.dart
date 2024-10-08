import 'package:injectable/injectable.dart';

import '../../../domain/repository/ai_repository.dart';
import '../../model/response/ask_ai_response.dart';
import '../source/remote/ai_remote.dart';

@LazySingleton(as: AiRepository)
class AiRepositoryImplementation implements AiRepository {
  final AiRemote _remote;
  AiRepositoryImplementation(this._remote);

  @override
  Future<AskAiResponse> askAi({
    required String question,
    required String userAddress,
  }) async {
    try {
      final result = await _remote.askAi(
        question: question,
        userAddress: userAddress,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
