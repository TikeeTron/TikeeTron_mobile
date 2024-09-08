import 'package:equatable/equatable.dart';

import '../../../../core/adapters/blockchain_network_adapter.dart';

class ResultCreateWalletModel extends Equatable {
  final String? seed;
  final String? privateKey;
  final String? address;
  final String? ecnryptedPrivateKey;

  final BlockchainNetwork? blockchainNetwork;
  final List<Map<String, Object>>? tokens;

  const ResultCreateWalletModel({
    this.seed,
    this.privateKey,
    this.address,
    this.ecnryptedPrivateKey,
    this.blockchainNetwork,
    this.tokens,
  });

  // create copy with
  ResultCreateWalletModel copyWith({
    String? seed,
    String? privateKey,
    String? address,
    String? ecnryptedPrivateKey,
    BlockchainNetwork? blockchainNetwork,
    List<Map<String, Object>>? tokens,
  }) {
    return ResultCreateWalletModel(
      seed: seed ?? this.seed,
      privateKey: privateKey ?? this.privateKey,
      address: address ?? this.address,
      ecnryptedPrivateKey: ecnryptedPrivateKey ?? this.ecnryptedPrivateKey,
      blockchainNetwork: blockchainNetwork ?? this.blockchainNetwork,
      tokens: tokens ?? this.tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'seed': seed,
      'privateKey': privateKey,
      'address': address,
      'ecnryptedPrivateKey': ecnryptedPrivateKey,
      'blockchainNetwork': blockchainNetwork,
      'tokens': tokens,
    };
  }

  @override
  List<Object?> get props => [
        seed,
        privateKey,
        address,
        ecnryptedPrivateKey,
        blockchainNetwork,
        tokens,
      ];

  @override
  String toString() {
    return 'ResultCreateWalletModel: ${toMap()}';
  }
}
