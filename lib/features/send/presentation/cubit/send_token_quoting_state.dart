part of 'send_token_quoting_cubit.dart';

class SendTokenQuotingState extends Equatable {
  const SendTokenQuotingState();

  @override
  List<Object?> get props => [];
}

class SendTokenQuotingInitialState extends SendTokenQuotingState {}

class SendTokenQuotingLoadingState extends SendTokenQuotingState {}

class SendTokenQuotingSuccessState extends SendTokenQuotingState {
  final int? networkFee;
  final double? exchangeRate;
  final double? amountInFiat;

  const SendTokenQuotingSuccessState({
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

class SendTokenQuotingErrorState extends SendTokenQuotingState {
  final String? message;

  const SendTokenQuotingErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
