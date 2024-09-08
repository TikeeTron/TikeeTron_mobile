part of 'create_wallet_cubit.dart';

class CreateWalletState extends Equatable {
  const CreateWalletState();

  @override
  List<Object?> get props => [];
}

class CreateWalletLoadingState extends CreateWalletState {}

class CreateWalletSuccessState extends CreateWalletState {
  final String? passedData;
  final String? pin;
  final WalletModel wallet;

  const CreateWalletSuccessState({
    this.passedData,
    required this.wallet,
    this.pin,
  });

  @override
  List<Object?> get props => [
        passedData,
        wallet,
        pin,
      ];
}

class CreateWalletErrorState extends CreateWalletState {
  final String? message;

  const CreateWalletErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
