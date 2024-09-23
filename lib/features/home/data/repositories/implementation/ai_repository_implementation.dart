import 'package:injectable/injectable.dart';

import '../../../domain/repository/ai_repository.dart';
import '../source/remote/ai_remote.dart';

@LazySingleton(as: AiRepository)
class AiRepositoryImplementation implements AiRepository {
  final AiRemote _remote;
  AiRepositoryImplementation(this._remote);

  @override
  Future<String> askAi({required String question}) async {
    try {
      final result = await _remote.askAi(question: question);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
