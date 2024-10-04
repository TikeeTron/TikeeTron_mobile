import '../data/model/transaction_model.dart';

abstract class TransactionRepository {
  Map<dynamic, dynamic>? getTransactionsByHash(String txHash);
  void insertTransactionHistory({
    required TransactionModel transaction,
  });
  Future<int?> getTxReceipt({required String txId});
}
