import 'package:equatable/equatable.dart';

import '../../../../common/enum/asset_type_enum.dart';
import '../../../../common/enum/transaction_state_enum.dart';
import '../../../../common/enum/transaction_type_enum.dart';

class TransactionModel extends Equatable {
  final String? title;
  final TransactionTypeEnum? transactionType;
  final AssetTypeEnum? assetType;
  final int? resourcesConsumed;
  final String? toAddress;
  final String? fromAddress;
  final String? date;
  final String? amount;
  final String? txId;
  final TransactionStateEnum? transactionStatus;

  TransactionModel({
    this.title,
    this.transactionType,
    this.assetType,
    this.resourcesConsumed,
    this.toAddress,
    this.fromAddress,
    this.date,
    this.amount,
    this.txId,
    this.transactionStatus,
  });

  TransactionModel copyWith({
    String? title,
    TransactionTypeEnum? transactionType,
    AssetTypeEnum? assetType,
    int? resourcesConsumed,
    String? toAddress,
    String? fromAddress,
    String? date,
    String? amount,
    String? txId,
    TransactionStateEnum? transactionStatus,
  }) {
    return TransactionModel(
      title: title ?? this.title,
      transactionType: transactionType ?? this.transactionType,
      assetType: assetType ?? this.assetType,
      resourcesConsumed: resourcesConsumed ?? this.resourcesConsumed,
      toAddress: toAddress ?? this.toAddress,
      fromAddress: fromAddress ?? this.fromAddress,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      txId: txId ?? this.txId,
      transactionStatus: transactionStatus ?? this.transactionStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'transactionType': transactionType.toString(),
      'assetType': assetType.toString(),
      'resourcesConsumed': resourcesConsumed,
      'toAddress': toAddress,
      'fromAddress': fromAddress,
      'date': date,
      'amount': amount,
      'txId': txId,
      'transactionStatus': transactionStatus?.toString(),
    };
  }

  factory TransactionModel.fromJson(Map<dynamic, dynamic> json) {
    return TransactionModel(
      title: json['title'],
      transactionType: TransactionTypeEnum.values.firstWhere((e) => e.toString() == json['transactionType']),
      assetType: AssetTypeEnum.values.firstWhere((e) => e.toString() == json['assetType']),
      resourcesConsumed: json['resourcesConsumed'],
      toAddress: json['toAddress'],
      fromAddress: json['fromAddress'],
      date: json['date'],
      amount: json['amount'],
      txId: json['txId'],
      transactionStatus: json['transactionStatus'] != null
          ? TransactionStateEnum.values.firstWhere(
              (e) => e.toString() == json['transactionStatus'],
            )
          : null,
    );
  }

  @override
  List<Object?> get props => [
        title,
        transactionType,
        assetType,
        resourcesConsumed,
        toAddress,
        fromAddress,
        date,
        txId,
        amount,
        transactionStatus,
      ];
}
