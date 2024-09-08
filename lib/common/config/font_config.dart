enum FontFamily {
  dmSans,
  poppins,
  gellix,
}

extension FontFamilyParsing on FontFamily {
  String get name {
    switch (this) {
      case FontFamily.dmSans:
        return 'DM Sans';
      case FontFamily.poppins:
        return 'Poppins';
      case FontFamily.gellix:
        return 'Gellix';
    }
  }
}
