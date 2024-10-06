import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/dio/api.config.dart';
import '../../../../../../common/error/exception.dart';
import '../../../../../../main.dart';
import '../../../model/request/get_list_ticket_request_params.dart';
import '../../../model/request/snyc_ticket_request.dart';
import '../../../model/response/get_detail_ticket_response.dart';
import '../../../model/response/get_list_ticket_response.dart';
import '../../../model/response/sync_ticket_response.dart';

@LazySingleton()
class TicketRemote {
  Future<GetListTIcketResponse?> getListTickets({required String accessToken, GetListTicketRequestParams? params}) async {
    try {
      final result = await AppApi(
        baseUrl: env.baseUrl,
        version: 1,
      ).get(
        '/tickets',
        params: params?.toJson(),
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (result == null) {
        throw const ServerException();
      }
      final response = GetListTIcketResponse.fromJson(result);
      if (response.statusCode != 200) {
        throw Exception('Failed get list event');
      } else {
        return response;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<GetDetailTicketResponse?> getDetailTicket({required String accessToken, required int ticketId}) async {
    try {
      final result = await AppApi(
        baseUrl: env.baseUrl,
        version: 1,
      ).get(
        '/tickets/$ticketId',
        params: {},
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (result == null) {
        throw const ServerException();
      }

      final response = GetDetailTicketResponse.fromJson(result);

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<SnycTicketResponse?> syncTicketData({
    required String accessToken,
    required SyncTicketRequest data,
  }) async {
    try {
      final result = await AppApi(
        baseUrl: env.baseUrl,
        version: 1,
      ).post(
        '/tickets',
        body: data.toJson(),
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (result == null) {
        throw const ServerException();
      }
      final response = SnycTicketResponse.fromJson(result);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
