class TronTransactionInfoModel {
  final String? id;
  final int? blockNumber;
  final int? blockTimeStamp;
  final List<String>? contractResult;
  final Receipt? receipt;

  TronTransactionInfoModel({
    this.id,
    this.blockNumber,
    this.blockTimeStamp,
    this.contractResult,
    this.receipt,
  });

  TronTransactionInfoModel copyWith({
    String? id,
    int? blockNumber,
    int? blockTimeStamp,
    List<String>? contractResult,
    Receipt? receipt,
  }) =>
      TronTransactionInfoModel(
        id: id ?? this.id,
        blockNumber: blockNumber ?? this.blockNumber,
        blockTimeStamp: blockTimeStamp ?? this.blockTimeStamp,
        contractResult: contractResult ?? this.contractResult,
        receipt: receipt ?? this.receipt,
      );

  factory TronTransactionInfoModel.fromJson(Map<String, dynamic> json) => TronTransactionInfoModel(
        id: json["id"],
        blockNumber: json["blockNumber"],
        blockTimeStamp: json["blockTimeStamp"],
        contractResult: json["contractResult"] == null ? [] : List<String>.from(json["contractResult"]!.map((x) => x)),
        receipt: json["receipt"] == null ? null : Receipt.fromJson(json["receipt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "blockNumber": blockNumber,
        "blockTimeStamp": blockTimeStamp,
        "contractResult": contractResult == null ? [] : List<dynamic>.from(contractResult!.map((x) => x)),
        "receipt": receipt?.toJson(),
      };
}

class Receipt {
  final int? netUsage;

  Receipt({
    this.netUsage,
  });

  Receipt copyWith({
    int? netUsage,
  }) =>
      Receipt(
        netUsage: netUsage ?? this.netUsage,
      );

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        netUsage: json["net_usage"],
      );

  Map<String, dynamic> toJson() => {
        "net_usage": netUsage,
      };
}
