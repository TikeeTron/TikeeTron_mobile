extension XNumber on num {
  String get toPriceFormat {
    if (this == toInt()) {
      return toInt().toString();
    } else {
      return toString();
    }
  }
}
