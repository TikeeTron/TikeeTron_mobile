import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../core/adapters/blockchain_network_adapter.dart';

class NetworkModel extends Equatable {
  final String? name;
  final String? symbol;
  final String? id;
  final String? chainKey;
  final String? lifiChainId;
  final int? decimals;
  final String? chainId;
  final String? explorer;
  final Web3Client? client;

  final String? multicall;
  final bool? eip1559;
  final String? nativeCoinId;
  final String? logo;
  final String? namespace;
  final BlockchainNetwork? blockchain;
  final String? defaultSwapTokenAddress;
  final String? defaultSwapTokenDestinationAddress;

  const NetworkModel({
    this.name,
    this.symbol,
    this.id,
    this.chainKey,
    this.lifiChainId,
    this.decimals,
    this.chainId,
    this.explorer,
    this.client,
    this.multicall,
    this.eip1559,
    this.nativeCoinId,
    this.logo,
    this.namespace,
    this.blockchain,
    this.defaultSwapTokenAddress,
    this.defaultSwapTokenDestinationAddress,
  });

  factory NetworkModel.fromJson(Map<Object, dynamic>? json) {
    return NetworkModel(
      name: json?['name'],
      symbol: json?['symbol'],
      id: json?['id'],
      chainKey: json?['chain-key'],
      lifiChainId: json?['lifi-chain-id'],
      decimals: json?['decimals'],
      chainId: json?['chainId'].toString(),
      explorer: json?['explorer'],
      client: json?['client'],
      multicall: json?['multicall'],
      eip1559: json?['eip1559'],
      nativeCoinId: json?['nativecoin-id'],
      logo: json?['logo'],
      namespace: json?['namespace'],
      blockchain: json?['network'],
      defaultSwapTokenAddress: json?['default_swap_token_address'],
      defaultSwapTokenDestinationAddress: json?['default_swap_token_destination_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
      'id': id,
      'chain-key': chainKey,
      'lifi-chain-id': lifiChainId,
      'decimals': decimals,
      'chainId': chainId,
      'explorer': explorer,
      'client': client,
      'multicall': multicall,
      'eip1559': eip1559,
      'nativecoin-id': nativeCoinId,
      'logo': logo,
      'namespace': namespace,
      'network': blockchain,
      'default_swap_token_address': defaultSwapTokenAddress,
      'default_swap_token_destination_address': defaultSwapTokenDestinationAddress,
    };
  }

  @override
  List<Object?> get props => [
        name,
        symbol,
        id,
        chainKey,
        lifiChainId,
        decimals,
        chainId,
        explorer,
        client,
        multicall,
        eip1559,
        nativeCoinId,
        logo,
        namespace,
        blockchain,
        defaultSwapTokenAddress,
        defaultSwapTokenDestinationAddress,
      ];

  @override
  String toString() {
    return 'NetworkModel ${toJson()}';
  }
}
