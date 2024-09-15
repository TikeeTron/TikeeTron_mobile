part of 'wallets_cubit.dart';

abstract class WalletsState extends Equatable {
  const WalletsState();

  @override
  List<Object?> get props => [];
}

class WalletsInitial extends WalletsState {}

class WalletsLoadingState extends WalletsState {}

class WalletsLoadedState extends WalletsState {
  final List<WalletModel> wallets;

  const WalletsLoadedState({
    required this.wallets,
  });

  @override
  List<Object?> get props => [
        wallets,
      ];
}

class WalletsErrorState extends WalletsState {
  final String? message;

  const WalletsErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
