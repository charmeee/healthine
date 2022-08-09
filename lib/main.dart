//import 'dart:html';
import 'dart:developer';

import 'package:healthin/Provider/user_provider.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Screen/auth/main_signin_screen.dart';
import 'Screen/main_layout.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Service/auth_request_api.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: '8a9e99aa7c39e4e0369b5ad69554c50b');
  runApp(ProviderScope(
    child: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'bonoteam',
        theme: ThemeData(),
        home: const MyApp(),
      ),
    ),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    //status = true;
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    //정보가다받아와질때까지 delay 넣어주면될듯
    initializeDateFormatting();
    await Future.delayed(const Duration(milliseconds: 200));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    //changeStatus();
    final isLogined = ref.watch(loginStateProvider);
    final user = ref.watch(userStateProvider);

    print("메인 status ${isLogined}");
    //status는 로그인정보가있는지
    //MyHome은 로그인되고 메인홈페이지
    //MainSignIn은 로그인 페이지'
    if (user.accessToken != null) {
      UserProfileRequest(user.accessToken).then((value) {
        ref.read(userStateProvider.notifier).state = value;
      });
    }
    return isLogined ? MyHome() : MainSignIn();
  }
}
