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

// class CustomInterceptor extends Interceptor {
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     print('[REQ] [${options.method}] ${options.uri}');
//
//     if (options.headers['accessToken'] == 'true') {
//       // 헤더 삭제
//       options.headers.remove('accessToken');
//
//       final token = await storage.read(key: 'accessToken');
//
//       // 실제 토큰으로 대체
//       options.headers.addAll({
//         'authorization': 'Bearer $token',
//       });
//     }
//   }
// }
