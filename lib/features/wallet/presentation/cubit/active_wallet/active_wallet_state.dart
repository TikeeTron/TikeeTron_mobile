part of 'active_wallet_cubit.dart';

class ActiveWalletState extends Equatable {
  final int? walletIndex;
  final WalletModel? wallet;
  final bool hideBalance;

  const ActiveWalletState({
    this.walletIndex,
    this.wallet,
    this.hideBalance = false,
  });

  @override
  List<Object?> get props => [
        walletIndex,
        wallet,
        hideBalance,
      ];

  ActiveWalletState copyWith({
    int? walletIndex,
    WalletModel? wallet,
    bool? hideBalance,
  }) {
    return ActiveWalletState(
      walletIndex: walletIndex ?? this.walletIndex,
      wallet: wallet ?? this.wallet,
      hideBalance: hideBalance ?? this.hideBalance,
    );
  }
}
