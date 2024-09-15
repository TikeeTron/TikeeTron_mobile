import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../../../core/core.dart';
import '../../../../../core/injector/locator.dart';
import '../../../data/model/wallet_model.dart';
import '../../../data/repositories/source/local/account_local_repository.dart';
import '../../../domain/repository/wallet_core_repository.dart';
import '../token_list/token_list_cubit.dart';

part 'active_wallet_state.dart';

class ActiveWalletCubit extends Cubit<ActiveWalletState> {
  final AccountLocalRepository accountLocalRepository;
  final WalletCoreRepository walletCore;

  ActiveWalletCubit({
    required this.accountLocalRepository,
    required this.walletCore,
  }) : super(const ActiveWalletState());

  WalletModel? getActiveWallet() {
    // get all wallets
    final wallets = walletCore.getWallets();
    if (wallets.isEmpty) {
      return null;
    }

    // get active wallet index
    int? activeWalletIndex = accountLocalRepository.get(
      AccountLocalRepository.activeWalletIndex,
    );

    if (activeWalletIndex == null || activeWalletIndex >= wallets.length || activeWalletIndex < 0) {
      // if active wallet null, or
      // active wallet index is greater than or equal to wallets length, or
      // active wallet index is less than 0,
      // set active wallet index to 0
      setActiveWallet(wallet: wallets.first);

      // set active wallet index to 0
      activeWalletIndex = 0;
    }

    // get active wallet
    final activeWallet = wallets[activeWalletIndex];

    // emit state
    safeEmit(ActiveWalletState(
      wallet: activeWallet,
      walletIndex: activeWalletIndex,
    ));

    return activeWallet;
  }

  Future<void> setActiveWallet({
    required WalletModel wallet,
  }) async {
    final List<WalletModel> wallets = walletCore.getWallets();

    List hashedData = [];
    for (var e in wallets) {
      hashedData.add(md5.convert(utf8.encode(e.toString())).toString());
    }
    final int index = hashedData.indexOf(md5.convert(utf8.encode(wallet.toString())).toString());

    // save active wallet index to local storage
    await accountLocalRepository.save(
      AccountLocalRepository.activeWalletIndex,
      index,
    );

    // TODO: Need this? --> do not disconnect
    // if (state.wallet != null) {
    //   // if previous active wallet is not null,
    //   // disconnect the wallet from wallet connect
    //   await wcService.disconnectPairingsByWalletAddress(
    //     walletAddress: walletCore.getWalletAddress(
    //       wallet: state.wallet!,
    //       blockchain: BlockchainNetwork.evm,
    //     ),
    //   );
    // }

    // emit state
    safeEmit(ActiveWalletState(
      wallet: wallet,
      walletIndex: index,
    ));

    // get token balance for active wallet
    BlocProvider.of<TokenListCubit>(
      navigationService.currentContext!,
    ).getTokenBalances(
      walletIndex: index,
    );
  }

  WalletModel? refreshWallet() {
    final wallets = walletCore.getWallets();
    if (wallets.isEmpty) {
      return null;
    }

    final activeWallet = wallets[state.walletIndex!];

    // emit state
    safeEmit(ActiveWalletState(
      wallet: activeWallet,
      walletIndex: state.walletIndex,
    ));

    return activeWallet;
  }

  void hideBalance({
    required bool value,
  }) async {
    try {
      // Save state to account repository
      await locator<AccountLocalRepository>().save(AccountLocalRepository.hideAllBalance, value);
    } catch (error) {
      // Make hide balance false when error
      safeEmit(state.copyWith(hideBalance: false));
    } finally {
      // Emit change when finally success save to account repository
      safeEmit(state.copyWith(hideBalance: value));
    }
  }
}
