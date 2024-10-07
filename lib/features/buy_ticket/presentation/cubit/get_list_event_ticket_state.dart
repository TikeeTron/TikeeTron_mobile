part of 'get_list_event_ticket_cubit.dart';

class GetListEventTicketState extends Equatable {
  const GetListEventTicketState();

  @override
  List<Object?> get props => [];
}

class GetListEventTicketInitialState extends GetListEventTicketState {}

class GetListEventTicketLoadingState extends GetListEventTicketState {}

class GetListEventTicketLoadedState extends GetListEventTicketState {
  final GetDetailEventResponse? listEvent;

  const GetListEventTicketLoadedState({
    this.listEvent,
  });

  GetListEventTicketLoadedState copyWith({
    GetDetailEventResponse? listEvent,
  }) {
    return GetListEventTicketLoadedState(
      listEvent: listEvent ?? this.listEvent,
    );
  }

  @override
  List<Object?> get props => [
        listEvent,
      ];
}

class GetListEventTicketErrorState extends GetListEventTicketState {
  final String? message;

  const GetListEventTicketErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
