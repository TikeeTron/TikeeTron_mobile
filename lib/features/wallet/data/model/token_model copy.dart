import 'package:equatable/equatable.dart';

import '../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../core/adapters/token_type_adapter.dart';

class TokenModel extends Equatable {
  final String? name;
  final String? logo;
  final String? symbol;
  final String? id;
  final bool? isNative;
  final Map<dynamic, dynamic>? detailPlatform;
  final double? balance;
  final double? balanceInFiat;
  final String? changes;
  final TokenType? tokenType;
  final double? price;
  final double? balanceBefore;

  // REMOVED
  // final String? walletAddress;
  // final BlockchainNetwork? blockchain;

  const TokenModel({
    this.name,
    this.logo,
    this.symbol,
    this.id,
    this.isNative,
    // this.blockchain,
    this.detailPlatform,
    // this.walletAddress,
    this.balance,
    this.balanceInFiat,
    this.changes,
    this.tokenType,
    this.price,
    this.balanceBefore,
  });

  factory TokenModel.fromJson(Map<dynamic, dynamic> json) => TokenModel(
        name: json['name'],
        logo: json['logo'],
        symbol: json['symbol'],
        id: json['id'],
        isNative: json['is_native'],
        // blockchain: json['blockchain'],
        detailPlatform: json['detail_platform'],
        // walletAddress: json['wallet_address'],
        balance: json['balance'],
        balanceInFiat: json['balanceInFiat'],
        changes: json['changes'],
        tokenType: json['token_type'],
        price: json['price'],
        balanceBefore: json['balanceBefore'],
      );

  TokenModel copyWith({
    String? name,
    String? logo,
    String? symbol,
    String? id,
    bool? isNative,
    BlockchainNetwork? blockchain,
    Map<dynamic, dynamic>? detailPlatform,
    String? walletAddress,
    double? balance,
    double? balanceInFiat,
    String? changes,
    TokenType? tokenType,
    double? price,
    double? balanceBefore,
  }) {
    return TokenModel(
      name: name ?? this.name,
      logo: logo ?? this.logo,
      symbol: symbol ?? this.symbol,
      id: id ?? this.id,
      isNative: isNative ?? this.isNative,
      // blockchain: blockchain ?? this.blockchain,
      detailPlatform: detailPlatform ?? this.detailPlatform,
      // walletAddress: walletAddress ?? this.walletAddress,
      balance: balance ?? this.balance,
      balanceInFiat: balanceInFiat ?? this.balanceInFiat,
      changes: changes ?? this.changes,
      tokenType: tokenType ?? this.tokenType,
      price: price ?? this.price,
      balanceBefore: balanceBefore ?? this.balanceBefore,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
      'symbol': symbol,
      'id': id,
      'is_native': isNative,
      // 'blockchain': blockchain,
      'detail_platform': detailPlatform,
      // 'wallet_address': walletAddress,
      'balance': balance,
      'balanceInFiat': balanceInFiat,
      'changes': changes,
      'token_type': tokenType,
      'price': price,
    };
  }

  @override
  List<Object?> get props => [
        name,
        logo,
        symbol,
        id,
        isNative,
        // blockchain,
        detailPlatform,
        // walletAddress,
        balance,
        balanceInFiat,
        changes,
        tokenType,
        price,
      ];

  @override
  String toString() {
    return 'TokenModel: ${toJson()}';
  }
}
