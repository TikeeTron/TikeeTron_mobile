part of 'get_list_user_ticket_cubit.dart';

class GetListUserTicketState extends Equatable {
  const GetListUserTicketState();

  @override
  List<Object?> get props => [];
}

class GetListUserTicketInitialState extends GetListUserTicketState {}

class GetListUserTicketLoadingState extends GetListUserTicketState {}

class GetListUserTicketLoadedState extends GetListUserTicketState {
  final GetListTicketResponse? listTicket;

  const GetListUserTicketLoadedState({
    this.listTicket,
  });

  GetListUserTicketLoadedState copyWith({
    GetListTicketResponse? listTicket,
  }) {
    return GetListUserTicketLoadedState(
      listTicket: listTicket ?? this.listTicket,
    );
  }

  @override
  List<Object?> get props => [
        listTicket,
      ];
}

class GetListUserTicketErrorState extends GetListUserTicketState {
  final String? message;

  const GetListUserTicketErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
