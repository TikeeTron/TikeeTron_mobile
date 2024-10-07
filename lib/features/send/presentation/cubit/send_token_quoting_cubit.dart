import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../blockchain/domain/repository/tron_core_repository.dart';
part 'send_token_quoting_state.dart';

@LazySingleton()
class SendTokenQuotingCubit extends Cubit<SendTokenQuotingState> {
  final TronCoreRepository _tronCoreRepository;
  SendTokenQuotingCubit(this._tronCoreRepository) : super(const SendTokenQuotingState());

  Future<void> quotingSend({
    required double amount,
    required String walletAddress,
    required String targetAddress,
  }) async {
    try {
      safeEmit(SendTokenQuotingLoadingState());

      final amountInFiat = await _tronCoreRepository.getTokenInFiat(tokenBalance: amount);
      final exchangeRate = await _tronCoreRepository.getTokenPrice();
      final networkFee = await _tronCoreRepository.getNetworkFee(
        walletAddress: walletAddress,
        targetAddress: targetAddress,
      );
      safeEmit(SendTokenQuotingSuccessState(
        amountInFiat: amountInFiat == 0.0 ? 0 : amountInFiat,
        exchangeRate: exchangeRate,
        networkFee: networkFee,
      ));
    } catch (error) {
      safeEmit(SendTokenQuotingErrorState(
        message: error.errorMessage,
      ));

      rethrow;
    }
  }

  Future<void> resetQuoting() async {
    safeEmit(SendTokenQuotingInitialState());
  }
}
