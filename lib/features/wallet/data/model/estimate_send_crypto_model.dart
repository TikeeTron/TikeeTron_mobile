import 'package:equatable/equatable.dart';

import 'token_model.dart';

class EstimateSendCryptoModel extends Equatable {
  final TokenModel? token;
  final double? amount;
  final String? amountInFiat;
  final BigInt? gasPrice;
  final double? gasNative;
  final BigInt? gasLimit;
  final BigInt? maxFee;
  final BigInt? maxPriority;
  final String? gasFeeFormatted;
  final double? gasFeePlain;
  final double? gasNativeFormatted;
  final double? valueInFiat;
  final double? total;
  final String? totalPlain;
  final String? totalInFiat;
  final double? priceCurrency;
  final bool? gasSpike;

  const EstimateSendCryptoModel(
      {this.token,
      this.amount,
      this.amountInFiat,
      this.gasPrice,
      this.gasNative,
      this.gasLimit,
      this.gasFeeFormatted,
      this.gasNativeFormatted,
      this.gasFeePlain,
      this.maxFee,
      this.maxPriority,
      this.valueInFiat,
      this.total,
      this.totalInFiat,
      this.totalPlain,
      this.priceCurrency,
      this.gasSpike});

  EstimateSendCryptoModel copyWith(
      {TokenModel? token,
      double? amount,
      String? amountInFiat,
      BigInt? gasPrice,
      double? gasNative,
      BigInt? gasLimit,
      String? gasFeeFormatted,
      double? gasNativeFormatted,
      double? gasFeePlain,
      BigInt? maxFee,
      BigInt? maxPriority,
      double? total,
      String? totalInFiat,
      double? valueInFiat,
      String? totalPlain,
      double? priceCurrency,
      bool? gasSpike}) {
    return EstimateSendCryptoModel(
        token: token ?? this.token,
        amount: amount ?? this.amount,
        amountInFiat: amountInFiat ?? this.amountInFiat,
        gasPrice: gasPrice ?? this.gasPrice,
        gasNative: gasNative ?? this.gasNative,
        gasLimit: gasLimit ?? this.gasLimit,
        gasFeeFormatted: gasFeeFormatted ?? this.gasFeeFormatted,
        gasNativeFormatted: gasNativeFormatted ?? this.gasNativeFormatted,
        gasFeePlain: gasFeePlain ?? this.gasFeePlain,
        maxFee: maxFee ?? this.maxFee,
        maxPriority: maxPriority ?? this.maxPriority,
        valueInFiat: valueInFiat ?? this.valueInFiat,
        total: total ?? this.total,
        totalInFiat: totalInFiat ?? this.totalInFiat,
        totalPlain: totalPlain ?? this.totalPlain,
        priceCurrency: priceCurrency ?? this.priceCurrency,
        gasSpike: gasSpike ?? this.gasSpike);
  }

  @override
  List<Object?> get props => [
        token,
        amount,
        amountInFiat,
        gasPrice,
        gasNative,
        gasLimit,
        gasFeeFormatted,
        gasNativeFormatted,
        gasFeePlain,
        maxFee,
        maxPriority,
        valueInFiat,
        total,
        totalInFiat,
        totalPlain,
        priceCurrency,
        gasSpike
      ];
}
