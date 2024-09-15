import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/credentials.dart';

class PrivateKeyModel extends Equatable {
  final EthPrivateKey? ethPrivateKey;
  final String? privateKey;
  final DescriptorSecretKey? descriptorSecretKey;

  const PrivateKeyModel({
    this.ethPrivateKey,
    this.privateKey,
    this.descriptorSecretKey,
  });

  @override
  List<Object?> get props => [
        ethPrivateKey,
        privateKey,
        descriptorSecretKey,
      ];
}
