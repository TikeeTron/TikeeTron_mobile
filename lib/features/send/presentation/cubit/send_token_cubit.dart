import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../common/enum/asset_type_enum.dart';
import '../../../../common/enum/transaction_state_enum.dart';
import '../../../../common/enum/transaction_type_enum.dart';
import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/helpers/format_date_helper.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../blockchain/domain/repository/tron_core_repository.dart';
import '../../../shared/data/model/transaction_model.dart';
import '../../../shared/domain/transaction_repository.dart';
import '../../../wallet/data/model/wallet_model.dart';
part 'send_token_state.dart';

@LazySingleton()
class SendTokenCubit extends Cubit<SendTokenState> {
  final TronCoreRepository _tronCoreRepository;
  final TransactionRepository _transactionRepository;
  SendTokenCubit(
    this._tronCoreRepository,
    this._transactionRepository,
  ) : super(
          const SendTokenState(),
        );

  Future<TransactionModel?> sendToken({
    required WalletModel wallet,
    required int resourcesConsumed,
  }) async {
    try {
      if (state is! SendToken) {
        throw Exception('Invalid state');
      }
      final currentState = state as SendToken;

      final targetAddress = currentState.targetAddress;
      final senderAddress = currentState.senderAddress;
      final amount = currentState.amount;

      final sendTransactionResult = await _tronCoreRepository.sendTransaction(
        walletAddress: senderAddress ?? '',
        targetAddress: targetAddress ?? '',
        amount: amount ?? '',
        wallet: wallet,
      );

      // insert transaction history
      if (sendTransactionResult != null) {
        final transaction = TransactionModel(
          title: 'Send Token',
          transactionType: TransactionTypeEnum.send,
          assetType: AssetTypeEnum.token,
          resourcesConsumed: resourcesConsumed,
          toAddress: currentState.targetAddress,
          fromAddress: currentState.senderAddress,
          date: formatDateTime(DateTime.now()),
          amount: amount,
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
      safeEmit(SendTokenErrorState(
        message: error.errorMessage,
      ));

      rethrow;
    }
  }

  Future<void> resetSendState() async {
    safeEmit(SendTokenInitialState());
  }

  void setCryptoAmount({
    required String amount,
  }) {
    safeEmit((state as SendToken).copyWith(
      amount: amount,
    ));
  }

  void setTargetAndSenderAddress({
    required String senderAddress,
    required String targetAddress,
  }) {
    safeEmit(
      SendToken(
        senderAddress: senderAddress,
        targetAddress: targetAddress,
      ),
    );
  }
}
