import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';

import 'dio_interceptor.dart';

typedef ErrorHandlerFunc = void Function(Object error);

class ApiClient {
  late int? version;
  late int? timeOut;
  late String? baseUrl;

  factory ApiClient({
    int? version,
    String? baseUrl,
    int? timeOut,
  }) {
    _singleton.version = version;
    _singleton.baseUrl = baseUrl;
    _singleton.timeOut = timeOut;

    return _singleton;
  }

  static final ApiClient _singleton = ApiClient._internal();

  ApiClient._internal();
  ApiResources api() => ApiResources(
        version: version,
        baseUrl: baseUrl,
        timeOut: timeOut,
      );
}

class ApiResources {
  /// An instance of [Dio] for executing network requests.
  final Dio _dio = Dio();

  static String chacheDirPath = '';

  /// An instance of [CancelToken] used to pre-maturely cancel
  /// network requests.
  final CancelToken _cancelToken = CancelToken();

  final Options dioOption = Options(
    headers: {"Accept": "application/json", "x-static-token": "hWmZq4t7w!z%C*F-JaNdRfUjXn2r5u8x/A?D(G+KbPeShVkYp3s6v9y\$B&E)H@Mc"},
    // contentType: "application/x-www-form-urlencoded",
  );

  final Options dioFormDataOption = Options(
    headers: {"Accept": "application/json", "x-static-token": "hWmZq4t7w!z%C*F-JaNdRfUjXn2r5u8x/A?D(G+KbPeShVkYp3s6v9y\$B&E)H@Mc"},
    // contentType: "application/x-www-form-urlencoded",
  );

  late String? baseUrl;
  late int? version;
  late int? timeOut;

  late BaseOptions _options = BaseOptions(
    baseUrl: 'https://api.tikeetron.cloud/api',
    validateStatus: (_) => true,
    contentType: Headers.jsonContentType,
    sendTimeout: const Duration(milliseconds: 60000),
    connectTimeout: const Duration(milliseconds: 60000),
    receiveTimeout: const Duration(milliseconds: 60000),
  );

  static ErrorHandlerFunc errorHandlerFunc = (err) {};
  static ErrorHandlerFunc dioErrorHandlerFunc = (err) {};

  ApiResources({
    this.version,
    this.baseUrl,
    this.timeOut,
  }) {
    _options = _options.copyWith(
      baseUrl: _apiBaseUrl(version, baseUrl),
      sendTimeout: Duration(milliseconds: timeOut ?? 60000),
      connectTimeout: Duration(milliseconds: timeOut ?? 60000),
      receiveTimeout: Duration(milliseconds: timeOut ?? 60000),
    );
    _dio.options = _options;
    _dio.interceptors.clear();

    _dio.interceptors.addAll([
      // RetryInterceptor(
      //   dio: _dio,
      //   logPrint: print,
      //   retries: 1,
      // ),
      // DioCacheInterceptor(options: _cacheOptions),
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          RequestOptions requestOptions = await DioInterceptor.requestInterceptor(options);
          return handler.next(requestOptions); //continue
        },
        onError: (DioException dioError, ErrorInterceptorHandler errorInterceptorHandler) => DioInterceptor.onError(dioError, errorInterceptorHandler),
        onResponse: (e, handler) => DioInterceptor.onResponse(e, handler),
      ),
      //  LogInterceptor(requestBody: true, responseBody: true)
    ]);
  }

  String _apiBaseUrl(int? version, String? baseUrl) {
    String url = 'https://api.tikeetron.cloud/api';

    if (baseUrl != null) {
      url = baseUrl;
    }

    if (version != null) {
      return '$url/v$version';
    }

    return url;
  }

  /// This method invokes the [cancel()] method on either the input
  /// [cancelToken] or internal [_cancelToken] to pre-maturely end all
  /// requests attached to this token.
  static void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken != null) {
      cancelToken.cancel();
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
    CacheOptions? cacheOptions,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: body,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioOption,
      );

      return response.data;
    } on DioException catch (err) {
      ApiResources.dioErrorHandlerFunc(err);
    } on SocketException catch (e) {
      ApiResources.errorHandlerFunc(e);
    } catch (e) {
      ApiResources.errorHandlerFunc(e);
    }
  }

  Future<dynamic> patch(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
    CacheOptions? cacheOptions,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.patch(
        path,
        data: body,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioOption,
      );

      return response.data;
    } on DioException catch (err) {
      ApiResources.dioErrorHandlerFunc(err);
    } on SocketException catch (e) {
      ApiResources.errorHandlerFunc(e);
    } catch (e) {
      ApiResources.errorHandlerFunc(e);
    }
  }

  Future<dynamic> put(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
    CacheOptions? cacheOptions,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: body,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioOption,
      );

      return response.data;
    } on DioException catch (err) {
      ApiResources.dioErrorHandlerFunc(err);
    } on SocketException catch (e) {
      ApiResources.errorHandlerFunc(e);
    } catch (e) {
      ApiResources.errorHandlerFunc(e);
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioOption,
      );

      return response.data;
    } on DioException catch (err) {
      ApiResources.dioErrorHandlerFunc(err);
    } on SocketException catch (e) {
      ApiResources.errorHandlerFunc(e);
    } catch (e) {
      ApiResources.errorHandlerFunc(e);
    }
  }

  static final MemCacheStore _cacheStore = MemCacheStore();
  Future<dynamic> getWithCache(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    Duration? cacheDuration = const Duration(hours: 12),
  }) async {
    final String cacheKey = '$path${params != null ? '?${params.toString()}' : 'pr'}';

    CacheOptions cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.refresh,
      hitCacheOnErrorExcept: [],
      maxStale: cacheDuration,
      priority: CachePriority.high,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: true,
    );

    final cacheInterceptor = DioCacheInterceptor(options: cacheOptions);

    if (!_dio.interceptors.contains(cacheInterceptor)) {
      _dio.interceptors.add(cacheInterceptor);
    }

    try {
      final Response response = await _dio.get(
        path,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: (options ?? dioOption).copyWith(
          extra: {
            'dio_cache_interceptor': cacheOptions,
          },
        ),
      );

      if (response.statusCode == 200) {
        // Simpan respons sukses ke cache secara manual
        final cacheResponse = CacheResponse(
          cacheControl: CacheControl(),
          content: utf8.encode(json.encode(response.data)),
          date: DateTime.now(),
          eTag: response.headers.value('etag'),
          expires: null,
          headers: utf8.encode(json.encode(response.headers.map)),
          key: cacheKey,
          lastModified: response.headers.value('last-modified'),
          maxStale: null,
          priority: CachePriority.high,
          requestDate: DateTime.now(),
          responseDate: DateTime.now(),
          url: response.requestOptions.uri.toString(),
        );
        await _cacheStore.set(cacheResponse);

        return response.data;
      } else if (response.statusCode == 429) {
        // Rate limit hit, coba ambil dari cache
        final cacheResponse = await _cacheStore.get(cacheKey);

        if (cacheResponse != null) {
          String cachedString = utf8.decode(cacheResponse.content ?? []);

          return json.decode(cachedString);
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: 'Rate limit exceeded and no cached data available',
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } on DioException catch (err) {
      ApiResources.dioErrorHandlerFunc(err);
    } on SocketException catch (e) {
      ApiResources.errorHandlerFunc(e);
    } catch (e) {
      ApiResources.errorHandlerFunc(e);
    }
  }

  Future<dynamic> upload(
    String path, {
    dynamic body,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: body,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioFormDataOption,
      );

      return response.data;
    } on DioException catch (err) {
      ApiResources.dioErrorHandlerFunc(err);
    } on SocketException catch (e) {
      ApiResources.errorHandlerFunc(e);
    } catch (e) {
      ApiResources.errorHandlerFunc(e);
    }
  }

  Future<dynamic> postWithoutException(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: body,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioOption,
      );

      return response.data;
    } on DioException catch (err) {
      if (kDebugMode) {
        debugPrint(err.message);
      }

      // rethrow;
      // ApiResources.dioErrorHandlerFunc(err);
    } catch (e) {
      // rethrow;
      // ApiResources.errorHandlerFunc(e);
    }
  }

  Future<dynamic> getWithoutException(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioOption,
      );

      return response.data;
    } on DioException catch (err) {
      if (kDebugMode) {
        debugPrint(err.toString());
      }

      // rethrow;
      // ApiResources.dioErrorHandlerFunc(err);
    } catch (e) {
      // rethrow;
      // ApiResources.errorHandlerFunc(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic body,
    Map<String, dynamic>? params,
    Options? options,
    CacheOptions? cacheOptions,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: body,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options ?? dioOption,
      );

      return response.data;
    } on DioException catch (err) {
      ApiResources.dioErrorHandlerFunc(err);
    } on SocketException catch (e) {
      ApiResources.errorHandlerFunc(e);
    } catch (e) {
      ApiResources.errorHandlerFunc(e);
    }
  }
}
