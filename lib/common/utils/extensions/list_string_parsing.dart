import 'dart:developer';
import 'dart:math' as math;

extension ListStringParsing on List<String> {
  void _logger(String message) {
    log(message, name: 'ListStringParsing');
  }

  List<String> get wcChains {
    _logger('this -> $this');

    final List<String> result = [];

    for (final account in this) {
      // get chain (eip155:137) from this String
      // eip155:137:0xDb773AA60D8f8C5012Ea0bF71FEc176169aa9287
      final chain = account.substring(0, account.lastIndexOf(':'));

      result.add(chain);
    }

    _logger('result -> $result');

    return result;
  }

  /// Convert WC List<String> accounts to List<String> of addresses
  ///
  /// Example:
  /// [eip155:137:0xDb773AA60D8f8C5012Ea0bF71FEc176169aa9287, eip155:137:0xDb773AA60D8f8C5012Ea0bF71FEc176169aa9287]
  /// to
  /// [0xDb773AA60D8f8C5012Ea0bF71FEc176169aa9287, 0xDb773AA60D8f8C5012Ea0bF71FEc176169aa9287]
  ///
  /// @return List<String> of addresses
  List<String> get wcAddresses {
    _logger('this -> $this');

    final List<String> result = [];

    for (final account in this) {
      final address = account.substring(account.lastIndexOf(':') + 1);

      result.add(address);
    }

    _logger('result -> $result');

    return result;
  }

  String get random {
    _logger('this -> $this');

    // generate random index
    int randomIndex = math.Random().nextInt(length);

    // get random key
    final random = this[randomIndex];

    _logger('random -> $random');

    return random;
  }

  /// Check if List<String> contains same element
  ///
  /// Example:
  /// - [a, b, c, a] -> true
  /// - [a, b, c, d] -> false
  bool get isContainSameElement {
    final result = toSet().length != length;

    return result;
  }
}
