import 'package:hive/hive.dart';

enum TokenType {
  custom,
}

class TokenTypeAdapter extends TypeAdapter<TokenType> {
  @override
  TokenType read(BinaryReader reader) {
    return TokenType.values[reader.readByte()];
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, obj) {
    writer.writeByte(obj.index);
  }
}
