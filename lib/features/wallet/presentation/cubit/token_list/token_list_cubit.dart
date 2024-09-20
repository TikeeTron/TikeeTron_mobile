import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/utils/extensions/object_parsing.dart';
import '../../../../../core/core.dart';
import '../../../domain/repository/token_core_repository.dart';
import '../active_wallet/active_wallet_cubit.dart';
import '../wallets/wallets_cubit.dart';

part 'token_list_state.dart';

@LazySingleton()
class TokenListCubit extends Cubit<TokenListState> {
  final TokenCoreRepository tokenCore;

  TokenListCubit({
    required this.tokenCore,
  }) : super(TokenListInitial());

  Future<void> getTokenBalances({required int walletIndex, bool? forceUpdate}) async {
    // if already loading, do nothing
    if (state is TokenListLoadingState) {
      return;
    }

    emit(TokenListLoadingState());

    try {
      await tokenCore.getTokensBalance(walletIndex: walletIndex, forceUpdate: forceUpdate);

      // refresh get active wallet
      BlocProvider.of<ActiveWalletCubit>(
        navigationService.currentContext!,
      ).refreshWallet();

      // refresh get wallets
      BlocProvider.of<WalletsCubit>(
        navigationService.currentContext!,
      ).getWallets();

      emit(TokenListLoadedState());
    } catch (error) {
      emit(TokenListErrorState(
        message: error.errorMessage,
      ));
    }
  }
}
