part of 'ask_ai_cubit.dart';

sealed class AskAiState extends Equatable {
  const AskAiState();

  @override
  List<Object> get props => [];
}

final class AskAiInitial extends AskAiState {}

final class AskAiLoading extends AskAiState {
  final String question;

  const AskAiLoading({
    required this.question,
  });

  @override
  List<Object> get props => [question];
}

final class AskAiLoaded extends AskAiState {
  final AskAiResponse result;
  final String question;

  const AskAiLoaded({
    required this.result,
    required this.question,
  });

  AskAiLoaded copyWith({
    AskAiResponse? result,
    String? message,
  }) {
    return AskAiLoaded(
      result: result ?? this.result,
      question: message ?? this.question,
    );
  }

  @override
  List<Object> get props => [result, question];
}

final class AskAiError extends AskAiState {
  final String message;

  const AskAiError({
    required this.message,
  });

  AskAiError copyWith({
    String? message,
  }) {
    return AskAiError(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}
