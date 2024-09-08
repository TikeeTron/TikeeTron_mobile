import 'package:bdk_flutter/bdk_flutter.dart';

import '../../../core/adapters/blockchain_network_adapter.dart';
import '../../error/exception.dart';
import 'exception_parsing.dart';

extension ObjectParsing on Object {
  String get errorMessage {
    if (this is InsufficientFundsException) {
      return "Insufficient balance";
    } else if (this is Exception) {
      return (this as Exception).message;
    } else if (this is InsufficientBalanceException) {
      return "Insufficient balance";
    } else if (this is CustomException) {
      return (this as CustomException).errorMessage;
    }

    return toString();
  }

  /// Check if the error message contains the word 'insufficient' and 'funds'
  bool isErrorInsufficentFunds({
    required BlockchainNetwork blockchain,
  }) {
    final message = toString().toLowerCase();

    bool result = false;

    switch (blockchain) {
      case BlockchainNetwork.tron:
      case BlockchainNetwork.btt:
        result = message.contains('insufficient') && (message.contains('funds') || (message.contains('balance')));

        break;
    }

    return result;
  }
}
