part of 'send_token_cubit.dart';

class SendTokenState extends Equatable {
  const SendTokenState();

  @override
  List<Object?> get props => [];
}

class SendTokenInitialState extends SendTokenState {}

class SendTokenLoadingState extends SendTokenState {}

class SendToken extends SendTokenState {
  final String? amount;
  final String? senderAddress;
  final String? targetAddress;
  final WalletModel? wallet;

  const SendToken({
    this.amount,
    this.senderAddress,
    this.targetAddress,
    this.wallet,
  });

  SendToken copyWith({
    String? amount,
    String? senderAddress,
    String? targetAddress,
    WalletModel? wallet,
  }) {
    return SendToken(
      amount: amount ?? this.amount,
      targetAddress: targetAddress ?? this.targetAddress,
      wallet: wallet ?? this.wallet,
      senderAddress: senderAddress ?? this.senderAddress,
    );
  }

  @override
  List<Object?> get props => [
        targetAddress,
        senderAddress,
        wallet,
        amount,
      ];
}

class SendTokenErrorState extends SendTokenState {
  final String? message;

  const SendTokenErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
