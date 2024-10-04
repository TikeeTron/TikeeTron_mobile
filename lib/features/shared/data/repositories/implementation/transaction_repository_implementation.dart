import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../blockchain/data/repositories/source/tron_remote.dart';
import '../../../domain/transaction_repository.dart';
import '../../model/transaction_model.dart';
import '../source/local/transaction_local_repository.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImplementation implements TransactionRepository {
  final TransactionLocalRepository _transactionLocalRepository;
  final TronRemote _tronRemote;
  TransactionRepositoryImplementation(
    this._transactionLocalRepository,
    this._tronRemote,
  );

  @override
  Map<dynamic, dynamic>? getTransactionsByHash(String txHash) {
    try {
      Logger.info('getTransactionsByHash txHash $txHash');

      Map<dynamic, dynamic>? result = {};
      final txHistory = _transactionLocalRepository.getAll();
      if (txHistory != null && txHistory.isNotEmpty) {
        result = txHistory.firstWhere(
          (element) {
            return element['txHash'] == txHash;
          },
          orElse: () => null,
        );
      }

      Logger.success('getTransactionsByHash result $result');

      return result;
    } catch (error) {
      Logger.error('getTransactionsByHash error $error');

      rethrow;
    }
  }

  @override
  Future<int?> getTxReceipt({required String txId}) async {
    try {
      final txReceiptNetUsage = await _tronRemote.getTransactionInfo(transactionId: txId);
      return txReceiptNetUsage;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void insertTransactionHistory({required TransactionModel transaction}) {
    try {
      Logger.info('insertTransactionHistory transaction $transaction');

      if (_transactionLocalRepository.getAll() != null) {
        if (_transactionLocalRepository.getAll()!.length >= 200) {
          _transactionLocalRepository.deleteAt(0);
        }
      }

      transaction = transaction.copyWith(
        date: DateFormat('MMMM dd yyyy, hh:mm a').format(DateTime.now()),
      );

      _transactionLocalRepository.add(transaction.toJson());
      Logger.success('insertTransactionHistory success');
    } catch (e) {
      rethrow;
    }
  }
}
