import '../../../../common/enum/transaction_type_enum.dart';

class ReceiptModel {
  final String title;
  final TransactionTypeEnum transactionType;
  ReceiptModel(this.title, this.transactionType);
}
