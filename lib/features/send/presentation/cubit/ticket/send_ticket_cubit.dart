import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/enum/asset_type_enum.dart';
import '../../../../../common/enum/transaction_state_enum.dart';
import '../../../../../common/enum/transaction_type_enum.dart';
import '../../../../../common/utils/extensions/object_parsing.dart';
import '../../../../../common/utils/extensions/string_parsing.dart';
import '../../../../../common/utils/helpers/format_date_helper.dart';
import '../../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../../blockchain/domain/repository/tron_core_repository.dart';
import '../../../../home/data/model/response/get_list_ticket_response.dart';
import '../../../../shared/data/model/transaction_model.dart';
import '../../../../shared/domain/transaction_repository.dart';
import '../../../../wallet/data/model/wallet_model.dart';
part 'send_ticket_state.dart';

@LazySingleton()
class SendTicketCubit extends Cubit<SendTicketState> {
  final TronCoreRepository _tronCoreRepository;
  final TransactionRepository _transactionRepository;
  SendTicketCubit(
    this._tronCoreRepository,
    this._transactionRepository,
  ) : super(
          const SendTicketState(),
        );

  Future<TransactionModel?> sendTicket({
    required WalletModel wallet,
    required int resourcesConsumed,
  }) async {
    try {
      if (state is! SendTicket) {
        throw Exception('Invalid state');
      }
      final currentState = state as SendTicket;

      final targetAddress = currentState.targetAddress;
      final senderAddress = currentState.senderAddress;
      final ticketDetails = currentState.ticketDetails;

      final sendTransactionResult = await _tronCoreRepository.sendTicket(
        walletAddress: senderAddress ?? '',
        targetAddress: targetAddress ?? '',
        ticketId: ticketDetails?.ticketId ?? 0,
        wallet: wallet,
        isTicketUsed: ticketDetails?.isUsed ?? false,
        ticketPrice: ticketDetails?.price ?? 0,
      );

      // insert transaction history
      if (sendTransactionResult != null) {
        final transaction = TransactionModel(
          title: 'Send Ticket',
          transactionType: TransactionTypeEnum.send,
          assetType: AssetTypeEnum.nft,
          resourcesConsumed: resourcesConsumed,
          toAddress: currentState.targetAddress,
          fromAddress: currentState.senderAddress,
          date: formatDateTime(DateTime.now()),
          amount: ticketDetails?.price.toString().amountInWeiToToken(
                decimals: 6,
                fractionDigits: 0,
              ),
          txId: sendTransactionResult,
          transactionStatus: TransactionStateEnum.success,
        );
        _transactionRepository.insertTransactionHistory(
          transaction: transaction,
        );
        return transaction;
      } else {
        return null;
      }
    } catch (error) {
      safeEmit(SendTicketErrorState(
        message: error.errorMessage,
      ));

      rethrow;
    }
  }

  Future<void> resetSendState() async {
    safeEmit(SendTicketInitialState());
  }

  void setSelectedTicket({
    required TicketDetails ticket,
  }) {
    safeEmit(SendTicket(ticketDetails: ticket));
  }

  void setTargetAndSenderAddress({
    String? senderAddress,
    String? targetAddress,
  }) {
    safeEmit((state as SendTicket).copyWith(
      senderAddress: senderAddress,
      targetAddress: targetAddress,
    ));
  }
}
