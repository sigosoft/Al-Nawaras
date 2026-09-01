import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../config/api_constants.dart';

class BaseClient {
  static final Dio _dio = _initDio();

  static Dio _initDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('\n=================== API REQUEST ===================');
          print('Method : ${options.method}');
          print('URL    : ${options.uri}');
          if (options.headers.isNotEmpty) {
            print('Headers: ${options.headers}');
          }
          if (options.data != null) {
            print('Body   : ${options.data}');
          }
          print('====================================================\n');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('\n=================== API RESPONSE ===================');
          print('URL        : ${response.requestOptions.uri}');
          print('Status Code: ${response.statusCode}');
          print('Response   : ${response.data}');
          print('====================================================\n');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('\n=================== API ERROR RESPONSE ===================');
          print('URL        : ${e.requestOptions.uri}');
          print('Status Code: ${e.response?.statusCode}');
          print('Error Data : ${e.response?.data}');
          print('Error Msg  : ${e.message}');
          print('==========================================================\n');
          return handler.next(e);
        },
      ),
    );

    return dio;
  }

  static Dio get dio => _dio;

  /// Centralized handling for Dio errors
  static void handleDioError(DioException e) {
    print('\n=================== DIO EXCEPTION ===================');
    print('URL        : ${e.requestOptions.uri}');
    print('Status Code: ${e.response?.statusCode}');
    print('Error Data : ${e.response?.data}');
    print('Error Msg  : ${e.message}');
    print('=====================================================\n');

    String errorMessage = 'A network error occurred. Please try again.';
    String title = 'Network Error';
    IconData icon = Icons.wifi_off;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      errorMessage =
          'Connection timeout. Please check your internet connection.';
    } else if (e.type == DioExceptionType.connectionError) {
      errorMessage =
          'Unable to connect to the server. Please verify your network.';
    } else if (e.type == DioExceptionType.badResponse) {
      title = 'Error';
      icon = Icons.error_outline;
      if (e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? 'Server error occurred.';
      } else {
        errorMessage = 'Server returned an invalid response.';
      }
    } else if (e.type == DioExceptionType.cancel) {
      errorMessage = 'Request was cancelled.';
    } else {
      errorMessage = 'An unexpected network error occurred.';
    }

    Get.snackbar(
      title,
      errorMessage,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(icon, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }
}
