import 'dart:typed_data';
import 'package:blockchain_utils/blockchain_utils.dart' as block;

extension Unique<E, Id> on List<E> {
  List<E> unique([
    Id Function(E element)? id,
    bool inplace = true,
  ]) {
    final ids = <dynamic>{};
    final list = inplace ? this : List<E>.from(this);

    list.retainWhere((x) {
      return ids.add(
        id != null ? id(x) : x as Id,
      );
    });

    return list;
  }

  /// Convert list of integers to base58 string.
  ///
  /// Example:
  /// - [1, 2, 3, 4, 5] => 'Ldp'
  String? get encodeBase58 {
    try {
      String? result;
      if (this is List<int>) {
        final bytes = Uint8List.fromList(this as List<int>);

        result = block.Base58Encoder.encode(bytes);
      }

      return result;
    } catch (error) {
      return null;
    }
  }
}
