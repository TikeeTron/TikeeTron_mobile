part of 'send_ticket_cubit.dart';

class SendTicketState extends Equatable {
  const SendTicketState();

  @override
  List<Object?> get props => [];
}

class SendTicketInitialState extends SendTicketState {}

class SendTicketLoadingState extends SendTicketState {}

class SendTicket extends SendTicketState {
  final TicketDetails? ticketDetails;
  final String? senderAddress;
  final String? targetAddress;

  const SendTicket({
    this.ticketDetails,
    this.senderAddress,
    this.targetAddress,
  });

  SendTicket copyWith({
    TicketDetails? ticketDetails,
    String? senderAddress,
    String? targetAddress,
    WalletModel? wallet,
  }) {
    return SendTicket(
      ticketDetails: ticketDetails ?? this.ticketDetails,
      targetAddress: targetAddress ?? this.targetAddress,
      senderAddress: senderAddress ?? this.senderAddress,
    );
  }

  @override
  List<Object?> get props => [
        ticketDetails,
        targetAddress,
        senderAddress,
      ];
}

class SendTicketErrorState extends SendTicketState {
  final String? message;

  const SendTicketErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
