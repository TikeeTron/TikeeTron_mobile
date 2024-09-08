import 'package:dio/dio.dart';

class DioInterceptor {
  static Future<RequestOptions> requestInterceptor(
    RequestOptions options,
  ) async {
    // String? token = await AuthPref.getToken();

    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    //   options.headers['x-access-token'] = token;
    // }

    // options.headers['Accept'] = 'application/json';
    // options.contentType = 'application/x-www-form-urlencoded';

    return options;
  }

  static Future<void> onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    final exclude = response.realUri.path == '/someurl';

    if (response.statusCode == 403 && exclude != true) {
      // await AuthPref.clear();
      // await AccountPref.clear();
      // await Preference.clear();

      // final NavigationServices navigationService =
      //     locator<NavigationServices>();

      // showFlutterToast('Sesi habis, silahkan login kembali', true);
      // navigationService.pushNamedAndRemoveUntil(AppRoutes.auth);
    }

    return handler.next(response);
  }

  static Future<void> onError(
    DioException dioError,
    ErrorInterceptorHandler errorInterceptorHandler,
  ) async {
    // if (dioError.type == DioErrorType.response) {
    final exclude = dioError.response?.realUri.path == '/someurl';

    if (dioError.response?.statusCode == 403 && exclude != true) {
      // await AuthPref.clear();
      // await AccountPref.clear();
      // await Preference.clear();

      // final NavigationServices navigationService =
      //     locator<NavigationServices>();

      // showFlutterToast('Sesi habis, silahkan login kembali', true);
      // navigationService.pushNamedAndRemoveUntil(AppRoutes.auth);
    }
    //   }

    errorInterceptorHandler.next(dioError);
  }
}
