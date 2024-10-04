part of 'active_wallet_cubit.dart';

class ActiveWalletState extends Equatable {
  final int? walletIndex;
  final WalletModel? wallet;
  final bool hideBalance;
  final int? freeNetUsage;

  const ActiveWalletState({
    this.walletIndex,
    this.wallet,
    this.hideBalance = false,
    this.freeNetUsage,
  });

  @override
  List<Object?> get props => [
        walletIndex,
        wallet,
        hideBalance,
        freeNetUsage,
      ];

  ActiveWalletState copyWith({
    int? walletIndex,
    WalletModel? wallet,
    bool? hideBalance,
    int? freeNetUsage,
  }) {
    return ActiveWalletState(
      walletIndex: walletIndex ?? this.walletIndex,
      wallet: wallet ?? this.wallet,
      hideBalance: hideBalance ?? this.hideBalance,
      freeNetUsage: freeNetUsage ?? this.freeNetUsage,
    );
  }
}
