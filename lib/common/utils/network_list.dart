import 'package:collection/collection.dart';
import 'package:http/io_client.dart' as tron_io;
import 'package:http/io_client.dart' as btt_io;
import 'package:web3dart/web3dart.dart';
import '../../core/adapters/blockchain_network_adapter.dart';
import 'helpers/logger_helper.dart';

class NetworkList {
  NetworkList._();

  static List<Map<String, dynamic>> networks = [
    {
      "name": "TRON",
      "symbol": "trx",
      "id": "tron",
      "chain-key": "tron",
      "decimals": 6,
      "chainId": "1000",
      "explorer": "https://tronscan.org/#/",
      "client": Web3Client("https://api.shasta.trongrid.io/jsonrpc", tron_io.IOClient()),
      "multicall": "0xC50F4c1E81c873B2204D7eFf7069Ffec6Fbe136D",
      "eip1559": false,
      "nativecoin-id": "tronix",
      "logo": "",
      "namespace": "eip155",
      "network": BlockchainNetwork.tron,
      "default_swap_token_address": "TNUC9Qb1rRpS5CbWLmNMxXBjyFoydXjWFR",
      "default_swap_token_destination_address": "0x55d398326f99059ff775485246999027b3197955",
    },
    {
      "name": "Bittorent",
      "symbol": "BTT",
      "id": "polygon-pos",
      "chain-key": "POL",
      "decimals": 18,
      "chainId": "137",
      "explorer": "https://polygonscan.com",
      "client": Web3Client("https://rpc.ankr.com/polygon", btt_io.IOClient()),
      "multicall": "0x275617327c958bD06b5D6b871E7f491D76113dd8",
      "eip1559": true,
      "nativecoin-id": "matic-network",
      "logo": "",
      "namespace": "eip155",
      "network": BlockchainNetwork.btt,
      "default_swap_token_address": "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
      "default_swap_token_destination_address": "0xc2132d05d31c914a87c6611c10748aeb04b58e8f",
    },
  ];

  static bool isNetworkExists(String id) {
    return networks.where((element) => element['id'] == id).toList().isNotEmpty;
  }

  static Web3Client? findClientById(String? id) {
    return networks.firstWhereOrNull((element) => element['id'] == id)?['client'];
  }

  static Map<Object, dynamic>? findNetworkById(String? id) {
    return networks.firstWhereOrNull((element) => element['id'] == id);
  }

  static Map<Object, dynamic>? findNetworkByNativeCoinId(String? nativeCoinId) {
    return networks.firstWhereOrNull((element) => element['nativecoin-id'] == nativeCoinId);
  }

  static Map<Object, dynamic>? findNetworkByNetworkId(String? networkId) {
    if (networkId == null) {
      return null;
    }

    return networks.firstWhereOrNull((element) => element['id'] == networkId);
  }

  static Map<Object, dynamic> findNetworkByName(String name) {
    return networks.firstWhere((element) => element['name'] == name);
  }

  static Map<Object, dynamic> findNetworkByExplorer(String explorer) {
    return networks.firstWhere((element) => element['explorer'] == explorer);
  }

  static String findChainIDByNetworkID(String id) {
    return networks.firstWhere((element) => element['id'] == id)['chainId'];
  }

  static bool isSupportEIP1559(String id) {
    return networks.firstWhere((element) => element['id'] == id)['eip1559'];
  }

  static String findNativeCoinID(String networkId) {
    return networks.firstWhere((element) => element['id'] == networkId)['nativecoin-id'];
  }

  static Map<String, dynamic>? findNetworkByChainID(String? chainId) {
    return networks.firstWhereOrNull((element) => element['chainId'] == chainId);
  }

  static Web3Client? findClientByChainId(String? chainId) {
    return networks.firstWhereOrNull((element) => element['chainId'] == chainId)?['client'];
  }

  static bool checkNamepsaceIsAvailable(String namespace) {
    return networks.firstWhereOrNull((element) => element['namespace'] == namespace) != null;
  }

  static bool checkNamespaceAndChainIdIsAvailable({
    required String? namespace,
    required String? chainId,
  }) {
    Logger.info('checkNamespaceAndChainIdIsAvailable: namespace: $namespace, chainId: $chainId');

    bool result = false;

    if (namespace != null && chainId != null) {
      result = networks.firstWhereOrNull((element) => element['namespace'] == namespace && element['chainId'] == chainId) != null ? true : false;
    }

    Logger.success('checkNamespaceAndChainIdIsAvailable result: $result');

    return result;
  }

  static bool isExplorerAvailable({required String? explorer}) {
    Logger.info('isExplorerAvailable: explorer: $explorer');

    bool result = false;

    if (explorer != null) {
      result = networks.firstWhereOrNull((element) => element['explorer'].toString().toLowerCase() == explorer.toLowerCase()) != null ? true : false;
    }

    Logger.success('isExplorerAvailable result: $result');

    return result;
  }
}
