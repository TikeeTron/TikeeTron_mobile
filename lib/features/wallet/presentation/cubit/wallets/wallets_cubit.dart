import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/utils/extensions/object_parsing.dart';
import '../../../data/model/wallet_model.dart';
import '../../../domain/repository/wallet_core_repository.dart';

part 'wallets_state.dart';

class WalletsCubit extends Cubit<WalletsState> {
  final WalletCoreRepository walletCore;

  WalletsCubit({
    required this.walletCore,
  }) : super(WalletsInitial());

  List<WalletModel> getWallets() {
    try {
      emit(WalletsLoadingState());

      final wallets = walletCore.getWallets();

      emit(WalletsLoadedState(wallets: wallets));

      return wallets;
    } catch (e) {
      emit(WalletsErrorState(message: e.errorMessage));

      rethrow;
    }
  }
}
