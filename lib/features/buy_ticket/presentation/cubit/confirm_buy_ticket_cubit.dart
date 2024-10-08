import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/enum/asset_type_enum.dart';
import '../../../../common/enum/transaction_state_enum.dart';
import '../../../../common/enum/transaction_type_enum.dart';
import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/extensions/string_parsing.dart';
import '../../../../common/utils/helpers/format_date_helper.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../blockchain/domain/repository/tron_core_repository.dart';
import '../../../home/data/model/response/get_detail_event_response.dart';
import '../../../shared/data/model/transaction_model.dart';
import '../../../shared/domain/transaction_repository.dart';
import '../../../wallet/data/model/wallet_model.dart';

part 'confirm_buy_ticket_state.dart';

@LazySingleton()
class ConfirmBuyTicketCubit extends Cubit<ConfirmBuyTicketState> {
  final TronCoreRepository _tronCoreRepository;
  final TransactionRepository _transactionRepository;
  ConfirmBuyTicketCubit(this._tronCoreRepository, this._transactionRepository) : super(const ConfirmBuyTicketState());

  Future<TransactionModel?> confirmBuyTicket({
    required int ticketPrice,
    required String ticketType,
    required String buyerAddress,
    required WalletModel wallet,
    required int networkFee,
    required int eventId,
  }) async {
    try {
      safeEmit(ConfirmBuyTicketLoadingState());
      final sendTransactionResult = await _tronCoreRepository.buyTicket(
        walletAddress: buyerAddress,
        ticketType: ticketType,
        ticketPrice: ticketPrice,
        wallet: wallet,
        eventId: eventId,
      );

      // insert transaction history
      if (sendTransactionResult != null) {
        final transaction = TransactionModel(
          title: ticketType,
          transactionType: TransactionTypeEnum.purchased,
          assetType: AssetTypeEnum.nft,
          resourcesConsumed: networkFee,
          toAddress: 'TMogKdMHLtPbmQRb9WckmbveGqZhyrqCyw',
          fromAddress: buyerAddress,
          date: formatDateTime(DateTime.now()),
          amount: ticketPrice.toString().amountInWeiToToken(
                decimals: 6,
                fractionDigits: 2,
              ),
          txId: sendTransactionResult,
          transactionStatus: TransactionStateEnum.success,
        );
        _transactionRepository.insertTransactionHistory(
          transaction: transaction,
        );

        safeEmit(const ConfirmBuyTicketLoadedState());
        return transaction;
      } else {
        safeEmit(const ConfirmBuyTicketErrorState(message: 'Failed buy ticket, please try again'));
        return null;
      }
    } catch (e) {
      safeEmit(
        ConfirmBuyTicketErrorState(
          message: e.errorMessage,
        ),
      );
      return null;
    }
  }
}
