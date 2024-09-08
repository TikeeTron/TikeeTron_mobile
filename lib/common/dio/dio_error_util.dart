import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dio_client.dart';

class DioExceptionUtil {
  // JUST FOR HANDLE SOME THINGS
  static handleApiError(BuildContext context) {
    late bool hasShow = false;

    ApiResources.errorHandlerFunc = (err) {
      // var baseErr = err as AppException;

      // print("ApiResources.errorHandlerFunc");
      // print(baseErr);

      // showFlutterToast(baseErr.message, true);
    };

    ApiResources.dioErrorHandlerFunc = (err) async {
      final Connectivity connectivity = Connectivity();
      var dioErr = err as DioException;

      // Future<void> showErrorDio() async {
      //   return await showServerDownBottomSheet(context);
      // }

      // Future<void> showErrorConnection() async {
      //   return await showNoConnectionBottomSheet(context);
      // }

      void checkWithConnectivity() async {
        final List<ConnectivityResult> connection = await connectivity.checkConnectivity();

        if (connection.contains(ConnectivityResult.none)) {
          if (!hasShow) {
            hasShow = true;
            // await showErrorConnection();
            hasShow = false;
          }
        } else {
          if (!hasShow) {
            hasShow = true;
            //  await showErrorDio();
            hasShow = false;
          }
        }
      }

      if (dioErr.type == DioExceptionType.connectionTimeout) {
        if (!hasShow) {
          hasShow = true;
          // await showErrorDio();
          hasShow = false;
        }
      } else if (dioErr.type == DioExceptionType.receiveTimeout) {
        if (!hasShow) {
          hasShow = true;
          // await showErrorDio();
          hasShow = false;
        }
      } else if (dioErr.type == DioExceptionType.sendTimeout) {
        if (!hasShow) {
          hasShow = true;
          // await showErrorDio();
          hasShow = false;
        }
      } else if (dioErr.type == DioExceptionType.cancel) {
        if (!hasShow) {
          hasShow = true;
          // await showErrorDio();
          hasShow = false;
        }
      } else if (dioErr.type == DioExceptionType.unknown) {
        checkWithConnectivity();
      } else {
        checkWithConnectivity();
      }
    };
  }
}
