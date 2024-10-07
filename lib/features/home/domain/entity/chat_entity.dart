import '../../data/model/response/ask_ai_response.dart';

class ChatEntity {
  final AskAiResponse? response;
  final bool isSystem;
  final bool isLoading;
  final bool isTyping;

  const ChatEntity({
    this.response,
    this.isSystem = false,
    this.isLoading = false,
    this.isTyping = false,
  });

  ChatEntity copyWith({
    AskAiResponse? response,
    bool? isSystem,
    bool? isLoading,
    bool? isTyping,
  }) =>
      ChatEntity(
        response: response ?? this.response,
        isSystem: isSystem ?? this.isSystem,
        isLoading: isLoading ?? this.isLoading,
        isTyping: isTyping ?? this.isTyping,
      );
}
