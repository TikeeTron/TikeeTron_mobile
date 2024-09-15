import 'package:equatable/equatable.dart';

import '../../../../core/adapters/blockchain_network_adapter.dart';

class WalletAddressModel extends Equatable {
  final BlockchainNetwork? blockchain;
  final String? address;

  const WalletAddressModel({
    this.blockchain,
    this.address,
  });

  factory WalletAddressModel.fromJson(Map<dynamic, dynamic> json) {
    return WalletAddressModel(
      blockchain: json['blockchain'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockchain': blockchain,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'WalletAddressModel ${toJson()}';
  }

  @override
  List<Object?> get props => [
        blockchain,
        address,
      ];
}
