import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/extensions/object_parsing.dart';
import '../../data/model/response/ask_ai_response.dart';
import '../../domain/repository/ai_repository.dart';

part 'ask_ai_state.dart';

@LazySingleton()
class AskAiCubit extends Cubit<AskAiState> {
  final AiRepository _aiRepository;

  AskAiCubit(
    this._aiRepository,
  ) : super(AskAiInitial());

  Future<void> askAi({
    required String question,
    required String userAddress,
  }) async {
    try {
      emit(AskAiLoading(question: question));

      final result = await _aiRepository.askAi(
        question: question,
        userAddress: userAddress,
      );
      emit(
        AskAiLoaded(
          result: result,
          question: question,
        ),
      );
    } catch (e) {
      emit(
        AskAiError(message: e.errorMessage),
      );
    }
  }
}
