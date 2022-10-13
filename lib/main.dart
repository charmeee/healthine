//import 'dart:html';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'Common/Database/secureStorage.dart';
import 'Common/dio/dio_handling.dart';
import 'Common/dio/dio_main.dart';
import 'User/screens/main_signin_screen.dart';
import 'firebase_options.dart';
import 'package:healthin/User/providers/user_provider.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Common/widgets/main_layout.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: '8a9e99aa7c39e4e0369b5ad69554c50b');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  var cj = PersistCookieJar(
      ignoreExpires: true, storage: FileStorage("$appDocPath/.cookies/"));
  dio.interceptors.add(
    CustomInterceptor(cj),
  );
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
    storage.delete(key: "accessToken");
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example becauseㄴ
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    //정보가다받아와질때까지 delay 넣어주면될듯
    initializeDateFormatting();
    try {
      await ref.read(userProfileNotifierProvider.notifier).getUserProfile();
      ref.read(loginStateProvider.notifier).state = true;
      log("자동로그인성공");
    } catch (e) {
      ref.read(loginStateProvider.notifier).state = false;
      log(e.toString());
      log("자동로그인 실패");
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    //changeStatus();
    final isLogined = ref.watch(loginStateProvider);
    print("메인 status $isLogined");
    //status는 로그인정보가있는지
    //MyHome은 로그인되고 메인홈페이지
    //MainSignIn은 로그인 페이지'
    final userProfile = ref.watch(userProfileNotifierProvider.notifier);
    if (isLogined == true) {
      userProfile.getUserProfile();
    }
    return isLogined ? MyHome() : MainSignIn();
  }
}
