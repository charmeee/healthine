import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const primaryColor = Color(0xFF24292f);
final storage = FlutterSecureStorage();

var options = BaseOptions(
  baseUrl: 'https://api.be-healthy.life',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = Dio(options);

// dio.interceptors.add(
//   CustomInterceptor(
//   ),
// );

class CustomInterceptor extends Interceptor {
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: 'accessToken');

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    return handler.next(options);
  }

  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('[RES] [${response.statusCode}] ${response.requestOptions.uri}');
    return handler.next(response);
  }

  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log('[ERR] [${err.response?.statusCode}] ${err.requestOptions.uri} ${err.message}');
    return handler.next(err);
  }
}
