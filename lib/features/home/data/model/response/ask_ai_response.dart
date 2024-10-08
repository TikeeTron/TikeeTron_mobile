import 'get_detail_ticket_response.dart';

class AskAiResponse {
  final String message;
  final List<Event> events;
  final List<GetDetailTicketResponse> tickets;

  const AskAiResponse({
    required this.message,
    this.events = const [],
    this.tickets = const [],
  });

  AskAiResponse copyWith({
    String? message,
    List<Event>? events,
    List<GetDetailTicketResponse>? tickets,
  }) =>
      AskAiResponse(
        message: message ?? this.message,
        events: events ?? this.events,
        tickets: tickets ?? this.tickets,
      );

  factory AskAiResponse.fromJson(Map<String, dynamic> json) => AskAiResponse(
        message: json['message'],
        events: List<Event>.from(json['events'].map((x) => Event.fromJson(x))),
        tickets: List<GetDetailTicketResponse>.from(
            json['tickets'].map((x) => GetDetailTicketResponse.fromJson(x))),
      );
}
