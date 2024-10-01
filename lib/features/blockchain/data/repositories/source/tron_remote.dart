import 'package:blockchain_utils/hex/hex.dart' as hex;
import 'package:injectable/injectable.dart';
import 'package:on_chain/on_chain.dart';

import '../../../../../common/dio/tron_provider.dart';
import '../../../../../common/utils/helpers/logger_helper.dart';

@LazySingleton()
class TronRemote {
  final rpc = TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io/"));

  Future<void> getTokenBalance({required String walletAddress}) async {
    final block = await rpc.request(TronRequestGetNowBlock());

    final blockHash = hex.hex.encode(block.blockHeader.rawData.parentHash ?? []);
    Logger.info('BLOCK HASH INFO ===> parent hash: ${blockHash}, raw hash:  ${block.blockID}, block Id: ${block.blockHeader.rawData.number.toString()}');
    final balance = await rpc.request(
      TronRequestGetAccount(
        address: TronAddress(walletAddress),
      ),
    );
    Logger.info('Account balance info $balance');
  }

  Future<TronAccountModel?> getTronAccount({required String walletAddress}) async {
    final tronAccount = await rpc.request(
      TronRequestGetAccount(
        address: TronAddress(walletAddress),
      ),
    );
    Logger.info('Account info $tronAccount');

    return tronAccount;
  }
}
