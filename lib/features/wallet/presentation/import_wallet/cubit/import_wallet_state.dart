part of 'import_wallet_cubit.dart';

abstract class ImportWalletState extends Equatable {
  const ImportWalletState();

  @override
  List<Object?> get props => [];
}

class ImportWalletInitial extends ImportWalletState {}

class ImportWalletLoadingState extends ImportWalletState {}

class ImportWalletLoadedState extends ImportWalletState {
  final WalletModel wallet;

  const ImportWalletLoadedState({
    required this.wallet,
  });

  @override
  List<Object?> get props => [
        wallet,
      ];
}

class ImportWalletErrorState extends ImportWalletState {
  final String? message;

  const ImportWalletErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
