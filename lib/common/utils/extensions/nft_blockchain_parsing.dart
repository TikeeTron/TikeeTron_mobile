import '../helpers/logger_helper.dart';
import '../network_list.dart';
import 'string_parsing.dart';

enum NftBlockchain {
  tron,
  btt,
}

extension NftBlockchainParsing on NftBlockchain {
  String get title {
    switch (this) {
      case NftBlockchain.tron:
        return "TRON";
      case NftBlockchain.btt:
        return "BTT";
    }
  }

  String get name {
    switch (this) {
      case NftBlockchain.tron:
        return "Tron";
      case NftBlockchain.btt:
        return "Bittorent";
    }
  }

  String get coinSymbol {
    switch (this) {
      case NftBlockchain.tron:
        return "TRN";
      case NftBlockchain.btt:
        return "BTT";
    }
  }

  String? toCollectionUrl({
    required String contract,
    String? tokenId,
  }) {
    try {
      Logger.info('toCollectionUrl params: this $this, contract $contract, tokenId $tokenId');

      String? result;

      final networkMap = NetworkList.findNetworkByName(title.toCapitalize());
      final explorer = networkMap['explorer'];

      switch (this) {
        case NftBlockchain.tron:
          final contractAddress = contract.split(':')[1];

          result = "$explorer/token/$contractAddress?a=$tokenId";
          break;
        case NftBlockchain.btt:
          result = "$explorer/token/$contract";
          break;
      }
      Logger.success('toCollectionUrl result: $result');

      return result;
    } catch (error) {
      Logger.error('toExplorerCollection error: $error');

      return null;
    }
  }
}
