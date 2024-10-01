import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/utils/extensions/string_parsing.dart';
import '../../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../../../core/core.dart';
import '../../../../../core/injector/locator.dart';
import '../../../../blockchain/domain/repository/tron_core_repository.dart';
import '../../../data/model/wallet_model.dart';
import '../../../data/repositories/source/local/account_local_repository.dart';
import '../../../domain/repository/wallet_core_repository.dart';
import '../token_list/token_list_cubit.dart';

part 'active_wallet_state.dart';

@LazySingleton()
class ActiveWalletCubit extends Cubit<ActiveWalletState> {
  final AccountLocalRepository accountLocalRepository;
  final WalletCoreRepository walletCore;
  final TronCoreRepository tronCoreRepository;
  final WalletCoreRepository walletCoreRepository;

  ActiveWalletCubit({
    required this.accountLocalRepository,
    required this.walletCore,
    required this.tronCoreRepository,
    required this.walletCoreRepository,
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
    final tronAccount = await tronCoreRepository.getTronAccount(walletAddress: wallet.addresses?[0].address ?? '');

    final totalBalance = tronAccount?.balance.toString().amountInWeiToToken(
          decimals: 6,
          fractionDigits: 2,
        );
    walletCore.updateWalletData(
      walletIndex: index,
      keyValue: [
        {
          "key": "lastUpdate",
          "value": DateTime.now(),
        },
        {
          "key": "totalBalance",
          "value": totalBalance,
        }
      ],
    );

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

  Future<void> getWalletBalance({required String walletAddress, required int walletIndex}) async {
    final tronAccount = await tronCoreRepository.getTronAccount(walletAddress: walletAddress);
    final totalBalance = tronAccount?.balance.toString().amountInWeiToToken(
          decimals: 6,
          fractionDigits: 2,
        );
    walletCore.updateWalletData(
      walletIndex: walletIndex,
      keyValue: [
        {
          "key": "lastUpdate",
          "value": DateTime.now(),
        },
        {
          "key": "totalBalance",
          "value": totalBalance,
        }
      ],
    );
    refreshWallet();
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
