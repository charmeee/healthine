import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:healthin/Common/Database/secureStorage.dart';

import 'dio_main.dart';

class CustomInterceptor extends Interceptor {
  final CookieJar cookieJar;
  CustomInterceptor(this.cookieJar);

  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('[REQ] [${options.method}] ${options.uri} ${options.data}');

    //쿠키 넣는 파트
    cookieJar.loadForRequest(options.uri).then((cookies) {
      var cookie = getCookies(cookies);
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
        RequestOptions requestOptions = err.requestOptions;
        final dio1 = Dio(options);
        dio1.interceptors.add(CookieManager(cookieJar));
        try {
          final refreshResponse = await dio1.patch("/auth/refresh", data: {});
          //토큰이안넣어짐..
          log("refresh token 발급 완료  ${refreshResponse.data["accessToken"]}");
          storage.delete(key: "accessToken");
          storage.write(
              key: "accessToken",
              value: refreshResponse.data["accessToken"].toString());
          final token = await storage.read(key: 'accessToken');
          //Authorization
          requestOptions.headers['Authorization'] = 'Bearer $token';
          //해더를 제대로 안넣어줘서 그럼..

          final response = await dio1.fetch(requestOptions);
          log("refresh 후 response: $response");
          //response를 provider 프로필에 넘겨줘야함.. 아마 dio를 riverpod에 감싸서 써야할것.
          return handler.resolve(response);
        } on DioError catch (err) {
          //헤드를 안줫더니 이거 에러잡혀서 계속 돌았음.
          //이거 에러잡히면 계속 돔..
          //뒤에 요청들을 다 cancel 해주거고 로그아웃 해줘야함.
          log("refreshtoken발급후 이후 요청 실패 - 서버문제 예싱");
          await storage.deleteAll();
          //return null;
          return handler.reject(err);
        }
        //
        // // dio.interceptors.requestLock.unlock();
        // // dio.interceptors.responseLock.unlock();

      }
    } else {
      return handler.reject(err);
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
