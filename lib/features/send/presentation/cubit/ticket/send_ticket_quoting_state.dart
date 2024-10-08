part of 'send_ticket_quoting_cubit.dart';

class SendTicketQuotingState extends Equatable {
  const SendTicketQuotingState();

  @override
  List<Object?> get props => [];
}

class SendTicketQuotingInitialState extends SendTicketQuotingState {}

class SendTicketQuotingLoadingState extends SendTicketQuotingState {}

class SendTicketQuotingSuccessState extends SendTicketQuotingState {
  final int? networkFee;
  final double? exchangeRate;

  const SendTicketQuotingSuccessState({this.networkFee, this.exchangeRate});

  @override
  List<Object?> get props => [
        networkFee,
        exchangeRate,
      ];
}

class SendTicketQuotingErrorState extends SendTicketQuotingState {
  final String? message;

  const SendTicketQuotingErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
