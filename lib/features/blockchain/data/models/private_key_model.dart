import 'package:equatable/equatable.dart';
import 'package:on_chain/on_chain.dart';

class PrivateKeyModel extends Equatable {
  final TronPrivateKey? tronPrivateKey;
  final String? privateKey;

  const PrivateKeyModel({
    this.tronPrivateKey,
    this.privateKey,
  });

  @override
  List<Object?> get props => [
        tronPrivateKey,
        privateKey,
      ];
}
