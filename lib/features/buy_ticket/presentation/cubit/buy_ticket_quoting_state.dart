part of 'buy_ticket_quoting_cubit.dart';

class BuyTicketQuotingState extends Equatable {
  const BuyTicketQuotingState();

  @override
  List<Object?> get props => [];
}

class BuyTicketQuotingInitialState extends BuyTicketQuotingState {}

class BuyTicketQuotingLoadingState extends BuyTicketQuotingState {}

class BuyTicketQuotingSuccessState extends BuyTicketQuotingState {
  final int? networkFee;
  final double? exchangeRate;
  final double? amountInFiat;

  const BuyTicketQuotingSuccessState({
    this.networkFee,
    this.exchangeRate,
    this.amountInFiat,
  });

  @override
  List<Object?> get props => [
        networkFee,
        exchangeRate,
        amountInFiat,
      ];
}

class BuyTicketQuotingErrorState extends BuyTicketQuotingState {
  final String? message;

  const BuyTicketQuotingErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
