import 'dart:convert';

import 'package:http/http.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/service.dart';

class RPCHttpService with JSONRPCService {
  RPCHttpService(this.url, {Client? client, this.defaultTimeOut = const Duration(seconds: 30)}) : client = client ?? Client();

  @override
  final String url;
  final Client client;
  final Duration defaultTimeOut;
  @override
  Future<Map<String, dynamic>> call(ETHRequestDetails params, [Duration? timeout]) async {
    final response = await client.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: params.toRequestBody()).timeout(timeout ?? defaultTimeOut);
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }
}
