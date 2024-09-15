import 'package:equatable/equatable.dart';

import '../../../../common/utils/extensions/dynamic_parsing.dart';

class TokenPriceModel extends Equatable {
  final double? usd;

  const TokenPriceModel({
    this.usd,
  });

  factory TokenPriceModel.fromJson(Map<String, dynamic> json) {
    return TokenPriceModel(
      usd: DynamicParsing(json['usd']).dynamicToDouble,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usd': usd,
    };
  }

  @override
  List<Object?> get props => [
        usd,
      ];
}
