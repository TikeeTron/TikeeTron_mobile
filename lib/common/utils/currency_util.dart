import 'package:intl/intl.dart';

class CurrencyUtils {
  String moneyFormat({dynamic amount, int decimal = 3, bool withSymbol = false}) {
    const symbol = '\$';

    final oCcy = NumberFormat.currency(locale: 'en_US', symbol: withSymbol ? symbol : '', decimalDigits: decimal);

    if (amount == null) {
      return oCcy.format(0).toString();
    }

    return oCcy.format(amount).toString();
  }

  String getDecimalSeparator() {
    return '.';
  }

  String getThousandSeparator() {
    return ',';
  }
}
