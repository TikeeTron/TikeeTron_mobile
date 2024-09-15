import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../data/model/wallet_model.dart';
import '../../domain/repository/wallet_core_repository.dart';

part 'create_wallet_state.dart';

@LazySingleton()
class CreateWalletCubit extends Cubit<CreateWalletState> {
  final WalletCoreRepository walletCore;

  CreateWalletCubit({
    required this.walletCore,
  }) : super(const CreateWalletState());

  String? pin;
  List<String>? mnemonic;
  WalletModel? wallet;

  Future<WalletModel> createWallet({
    dynamic passedData,
  }) async {
    try {
      safeEmit(CreateWalletLoadingState());

      // create wallet
      final result = await walletCore.createWallet();

      safeEmit(CreateWalletSuccessState(
        passedData: passedData,
        wallet: result,
      ));

      return result;
    } catch (error) {
      safeEmit(CreateWalletErrorState(
        message: error.errorMessage,
      ));

      rethrow;
    }
  }

  void setPin(String pin) {
    this.pin = pin;
  }

  void setMnemonic(List<String> mnemonic) {
    this.mnemonic = mnemonic;
  }

  void setWallet(WalletModel wallet) {
    this.wallet = wallet;
  }
}
