import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../blockchain/domain/repository/tron_core_repository.dart';
part 'buy_ticket_quoting_state.dart';

@LazySingleton()
class BuyTicketQuotingCubit extends Cubit<BuyTicketQuotingState> {
  final TronCoreRepository _tronCoreRepository;
  BuyTicketQuotingCubit(this._tronCoreRepository) : super(const BuyTicketQuotingState());

  Future<void> quotingBuyTicket({
    required String walletAddress,
    required String targetAddress,
  }) async {
    try {
      safeEmit(BuyTicketQuotingLoadingState());

      final exchangeRate = await _tronCoreRepository.getTokenPrice();
      final networkFee = await _tronCoreRepository.getNetworkFee(
        walletAddress: walletAddress,
        targetAddress: targetAddress,
      );
      safeEmit(BuyTicketQuotingSuccessState(
        exchangeRate: exchangeRate,
        networkFee: networkFee ?? 0,
      ));
    } catch (error) {
      safeEmit(BuyTicketQuotingErrorState(
        message: error.errorMessage,
      ));

      rethrow;
    }
  }

  Future<void> resetQuoting() async {
    safeEmit(BuyTicketQuotingInitialState());
  }
}
