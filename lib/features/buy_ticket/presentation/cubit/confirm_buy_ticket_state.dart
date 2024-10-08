part of 'confirm_buy_ticket_cubit.dart';

class ConfirmBuyTicketState extends Equatable {
  const ConfirmBuyTicketState();

  @override
  List<Object?> get props => [];
}

class ConfirmBuyTicketInitialState extends ConfirmBuyTicketState {}

class ConfirmBuyTicketLoadingState extends ConfirmBuyTicketState {}

class ConfirmBuyTicketLoadedState extends ConfirmBuyTicketState {
  final GetDetailEventResponse? selectedTicket;

  const ConfirmBuyTicketLoadedState({
    this.selectedTicket,
  });

  ConfirmBuyTicketLoadedState copyWith({
    GetDetailEventResponse? selectedTicket,
  }) {
    return ConfirmBuyTicketLoadedState(
      selectedTicket: selectedTicket ?? this.selectedTicket,
    );
  }

  @override
  List<Object?> get props => [
        selectedTicket,
      ];
}

class ConfirmBuyTicketErrorState extends ConfirmBuyTicketState {
  final String? message;

  const ConfirmBuyTicketErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
