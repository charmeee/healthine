////import 'dart:html';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'Common/Const/global.dart';
import 'Common/Database/secureStorage.dart';
import 'Common/Secret/secret.dart';
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
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: kakaoTalkKey);
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
        navigatorKey: navigatorState,
        title: 'bonoteam',
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            textTheme: TextTheme()
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
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
    //storage.delete(key: "accessToken");
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyHome();
      }));
    } catch (e) {
      print(e);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainSignIn();
      }));
    }
    //FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    //changeStatus();
    // final isLogined = ref.watch(loginStateProvider);
    // print("메인 status $isLogined");
    //status는 로그인정보가있는지
    //MyHome은 로그인되고 메인홈페이지
    //MainSignIn은 로그인 페이지'
    //return isLogined ? MyHome() : MainSignIn();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/logo.svg",
          width: MediaQuery.of(context).size.width * 0.6,
        ),
        CircularProgressIndicator(
          color: Colors.white,
        ),
      ],
    );
  }
}
