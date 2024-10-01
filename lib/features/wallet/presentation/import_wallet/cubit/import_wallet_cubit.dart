import 'package:bloc/bloc.dart';
import 'package:blockchain_utils/blockchain_utils.dart' as block;
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/wallet_model.dart';
import '../../../domain/repository/wallet_core_repository.dart';

part 'import_wallet_state.dart';

@LazySingleton()
class ImportWalletCubit extends Cubit<ImportWalletState> {
  final WalletCoreRepository walletCore;

  ImportWalletCubit({
    required this.walletCore,
  }) : super(ImportWalletInitial());

  Future<WalletModel> importWallet(
    String? seed,
  ) async {
    emit(ImportWalletLoadingState());

    try {
      final wallet = await walletCore.importWallet(mnemonic: block.Mnemonic.fromString(seed!));

      emit(ImportWalletLoadedState(wallet: wallet));

      return wallet;
    } catch (e) {
      emit(ImportWalletErrorState(message: e.toString()));

      rethrow;
    }
  }
}
