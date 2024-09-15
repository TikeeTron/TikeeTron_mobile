import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

class GasPriceModel extends Equatable {
  final EtherAmount? gas;
  final BigInt? wei;
  final double? gwei;
  final BigInt? baseWei;
  final double? baseGwei;
  final BigInt? priorityWei;
  final double? priorityGwei;

  const GasPriceModel({
    this.gas,
    this.wei,
    this.gwei,
    this.baseWei,
    this.baseGwei,
    this.priorityWei,
    this.priorityGwei,
  });

  GasPriceModel copyWith({
    EtherAmount? gas,
    BigInt? wei,
    double? gwei,
    BigInt? baseWei,
    double? baseGwei,
    BigInt? priorityWei,
    double? priorityGwei,
  }) {
    return GasPriceModel(
      gas: gas ?? this.gas,
      wei: wei ?? this.wei,
      gwei: gwei ?? this.gwei,
      baseWei: baseWei ?? this.baseWei,
      baseGwei: baseGwei ?? this.baseGwei,
      priorityWei: priorityWei ?? this.priorityWei,
      priorityGwei: priorityGwei ?? this.priorityGwei,
    );
  }

  @override
  List<Object?> get props => [
        gas,
        wei,
        gwei,
        baseWei,
        baseGwei,
        priorityWei,
        priorityGwei,
      ];
}
