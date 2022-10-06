import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:healthin/Database/secureStorage.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../auth_request_api.dart';
import 'dio_main.dart';

class CustomInterceptor extends Interceptor {
  final CookieJar cookieJar;
  CustomInterceptor(this.cookieJar);

  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('[REQ] [${options.method}] ${options.uri}');

    //쿠키 넣는 파트
    cookieJar.loadForRequest(options.uri).then((cookies) {
      var cookie = getCookies(cookies);

      log('onRequest | cookie: $cookie');
      if (cookie.isNotEmpty) {
        options.headers[HttpHeaders.cookieHeader] = cookie;
        log('onRequest | headers: ${options.headers} body:${options.data}');
      }
    }).catchError((e, stackTrace) {
      var err = DioError(requestOptions: options, error: e);
      err.stackTrace = stackTrace;
      handler.reject(err, true);
    });

    //해더 변환하는 파트
    if (options.headers['Authorization'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: 'accessToken');

      // 실제 토큰으로 대체
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      log("header: ${options.headers}");
    }
    return handler.next(options);
  }

  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('[RES] [${response.statusCode}] ${response.requestOptions.uri} cookie:${response.headers['set-cookie']}');

    //쿠키저장하는 파트
    _saveCookies(response)
        .then((_) => handler.next(response))
        .catchError((e, stackTrace) {
      var err = DioError(requestOptions: response.requestOptions, error: e);
      err.stackTrace = stackTrace;
      handler.reject(err, true);
    });
  }

  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log('[ERR] [${err.response?.statusCode}] ${err.requestOptions.uri} ${err.message} ~-~:${err.response?.data["message"]}');
    if (err.response != null) {
      //Unauthorized 에러 -> refreshToken으로 재요청 -> 실패시 로그아웃
      _saveCookies(err.response!)
          .then((_) => handler.next(err))
          .catchError((e, stackTrace) {
        var _err = DioError(
          requestOptions: err.response!.requestOptions,
          error: e,
        );
        _err.stackTrace = stackTrace;
      });
      if (err.response!.statusCode == 401 &&
          err.response!.data["message"] == "Unauthorized") {
        log("Unauthorized handler 실행");
        //나중에 queuedIndicator로 바꿔야함
        // RequestOptions requestOptions = err.requestOptions;
        // dio.interceptors.requestLock.lock();
        // dio.interceptors.responseLock.lock();
        // try {
        //   dio.interceptors.requestLock.unlock();
        //   dio.interceptors.responseLock.unlock();
        //   await refreshTokenRequest(); //api
        //   log("refreshTokenRequest 성공");
        //   final opts = new Options(method: requestOptions.method);
        //   dio.options.headers["Accept"] = "*/*";
        //   try {
        //     final response = await dio.request(requestOptions.path,
        //         options: opts,
        //         cancelToken: requestOptions.cancelToken,
        //         onReceiveProgress: requestOptions.onReceiveProgress,
        //         data: requestOptions.data,
        //         queryParameters: requestOptions.queryParameters);
        //     log("refresh 후 response: $response");
        //     if (response.statusCode == 200 || response.statusCode == 201) {
        //       handler.resolve(response);
        //     } else {
        //       return null;
        //     }
        //   } catch (e) {
        //     log("refreshTokenRequest 실패");
        //     await storage.deleteAll();
        //     return handler.reject(err);
        //   }
        // } catch (e) {
        //   log("error: $e");
        //   // dio.interceptors.requestLock.unlock();
        //   // dio.interceptors.responseLock.unlock();
        //   return null;
        // }
        //
        // // dio.interceptors.requestLock.unlock();
        // // dio.interceptors.responseLock.unlock();

      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _saveCookies(Response response) async {
    var cookies = response.headers[HttpHeaders.setCookieHeader];

    if (cookies != null) {
      await cookieJar.saveFromResponse(
        response.requestOptions.uri,
        cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),
      );
    }
  }

  static String getCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }
}
