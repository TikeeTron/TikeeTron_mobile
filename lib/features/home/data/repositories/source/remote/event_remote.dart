import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/dio/api.config.dart';
import '../../../../../../common/error/exception.dart';
import '../../../model/response/get_detail_event_response.dart';
import '../../../model/response/get_list_event_response.dart';

@LazySingleton()
class EventRemote {
  Future<GetListEventResponse?> getListEvent({required String accessToken}) async {
    try {
      final result = await AppApi(
        version: 1,
      ).get(
        '/events',
        params: {
          "take": 50,
          "page": 1,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (result == null) {
        throw const ServerException();
      }

      final response = GetListEventResponse.fromJson(result);
      if (response.statusCode != 200) {
        throw Exception('Failed get list event');
      } else {
        return response;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<GetDetailEventResponse?> getDetailEvent({required int eventId, required String accessToken}) async {
    try {
      final result = await AppApi(
        version: 1,
      ).get(
        '/events/$eventId',
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (result == null) {
        throw const ServerException();
      }
      final response = GetDetailEventResponse.fromJson(result);
      if (response.statusCode != 200) {
        throw Exception('Failed get list event');
      } else {
        return response;
      }
    } catch (error) {
      rethrow;
    }
  }
}
