import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'dio_handling.dart';

var options = BaseOptions(
  baseUrl: 'https://api.be-healthy.life',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = Dio(options);
// FutureProvider<Dio> dioProvider = FutureProvider<Dio>((ref) async {
//   var options = BaseOptions(
//     baseUrl: 'https://api.be-healthy.life',
//     connectTimeout: 5000,
//     receiveTimeout: 3000,
//   );
//   final dio = Dio(options);
//   Directory appDocDir = await getApplicationDocumentsDirectory();
//   String appDocPath = appDocDir.path;
//   var cj = PersistCookieJar(
//       ignoreExpires: true, storage: FileStorage("$appDocPath/.cookies/"));
//   dio.interceptors.add(
//     CustomInterceptor(
//       cookieJar: cj,
//     ),
//   );
//   return dio;
// });
