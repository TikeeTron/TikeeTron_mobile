import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/utils/extensions/object_parsing.dart';
import '../../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../../blockchain/domain/repository/tron_core_repository.dart';
part 'send_ticket_quoting_state.dart';

@LazySingleton()
class SendTicketQuotingCubit extends Cubit<SendTicketQuotingState> {
  final TronCoreRepository _tronCoreRepository;
  SendTicketQuotingCubit(this._tronCoreRepository) : super(const SendTicketQuotingState());

  Future<void> quotingSendTicket({
    required double amount,
    required String walletAddress,
    required String targetAddress,
  }) async {
    try {
      safeEmit(SendTicketQuotingLoadingState());
      final exchangeRate = await _tronCoreRepository.getTokenPrice();

      final networkFee = await _tronCoreRepository.getNetworkFee(
        walletAddress: walletAddress,
        targetAddress: targetAddress,
      );
      safeEmit(SendTicketQuotingSuccessState(
        networkFee: networkFee,
        exchangeRate: exchangeRate,
      ));
    } catch (error) {
      safeEmit(SendTicketQuotingErrorState(
        message: error.errorMessage,
      ));

      rethrow;
    }
  }

  Future<void> resetQuoting() async {
    safeEmit(SendTicketQuotingInitialState());
  }
}
