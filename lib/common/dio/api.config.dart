import 'package:dio/dio.dart';

import '../dio/dio_client.dart';
import '../dio/dio_exception.dart';
import '../utils/helpers/toast_helper.dart';
import '../utils/object_util.dart';

class AppApi {
  final int? version;
  final int? timeOut;
  final String? baseUrl;

  AppApi({
    this.version,
    this.baseUrl,
    this.timeOut,
  });

  Future<dynamic> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().post(path, body: body, params: params, options: options);
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().get(path, params: params, cancelToken: cancelToken, options: options);
  }

  Future<dynamic> getWithCache(
    String path, {
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    Duration? cacheDuration,
    Options? options,
  }) async {
    return await ApiClient(version: version, baseUrl: baseUrl, timeOut: timeOut).api().getWithCache(
          path,
          params: params,
          cancelToken: cancelToken,
          cacheDuration: cacheDuration,
          options: options,
        );
  }

  Future<dynamic> patch(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().patch(path, body: body, params: params, options: options);
  }

  Future<dynamic> put(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().put(path, body: body, params: params);
  }

  Future<dynamic> getWithoutException(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().getWithoutException(path, params: params);
  }

  Future<dynamic> upload(
    String path, {
    dynamic body,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().upload(path, body: body);
  }

  Future<dynamic> postWithoutException(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().postWithoutException(path, body: body, params: params);
  }

  Future<dynamic> delete(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return await ApiClient(
      version: version,
      baseUrl: baseUrl,
      timeOut: timeOut,
    ).api().delete(path, body: body, params: params, options: options);
  }

  static void handleShowMessage(dynamic resData) {
    if (resData != null && resData['message'] != null) {
      toastHelper.showInformation(resData['message']);
    }
  }
}

class ApiErrorUtils {
  static const String internalServerError = 'Server is under maintenance.';
  static const String unknownError = 'Unknown error occured.';
}

dynamic handleGetData(dynamic resData) {
  if (ObjectUtil.notStringAndNull(resData)) {
    final isSucess = resData['status'] == 200;

    if (isSucess && resData['data'] != null) {
      return resData['data'];
    } else if (resData['message'] != null) {
      throw AppException(resData['message'] ?? ApiErrorUtils.unknownError);
    } else {
      throw AppException(ApiErrorUtils.unknownError);
    }
  } else {
    throw AppException(ApiErrorUtils.unknownError);
  }
}

dynamic handleGetResponse(dynamic resData) {
  if (ObjectUtil.notStringAndNull(resData)) {
    return resData;
  } else {
    throw AppException(ApiErrorUtils.unknownError);
  }
}
