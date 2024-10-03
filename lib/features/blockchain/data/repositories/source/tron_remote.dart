import 'dart:developer';

import 'package:blockchain_utils/hex/hex.dart' as hex;
import 'package:injectable/injectable.dart';
import 'package:on_chain/on_chain.dart';

import '../../../../../common/dio/api.config.dart';
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
      const Duration(seconds: 5),
    );
    Logger.info('Account info $tronAccount');

    return tronAccount;
  }

  Future<double?> getTokenPrice() async {
    final result = await AppApi().getWithCache(
      'https://api.coingecko.com/api/v3/simple/token_price/tron?contract_addresses=TNUC9Qb1rRpS5CbWLmNMxXBjyFoydXjWFR&vs_currencies=usd',
    );
    if (result != null) {
      final tokenPrice = result['TNUC9Qb1rRpS5CbWLmNMxXBjyFoydXjWFR']['usd'];
      return tokenPrice;
    } else {
      return null;
    }
  }
}
