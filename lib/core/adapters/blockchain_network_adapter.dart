import 'package:hive/hive.dart';

enum BlockchainNetwork {
  tron,
  btt,
}

class BlockchainNetworkAdapter extends TypeAdapter<BlockchainNetwork> {
  @override
  BlockchainNetwork read(BinaryReader reader) {
    return BlockchainNetwork.values[reader.readByte()];
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, obj) {
    writer.writeByte(obj.index);
  }
}
