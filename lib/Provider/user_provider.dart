import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';
import 'package:healthin/Service/auth_request_api.dart';

//로그인 여부
final loginStateProvider = StateProvider<bool>((ref) => false);

//사용자 정보
final userStateProvider = StateProvider<UserInfo>((ref) {
  log("userState 변경");
  return UserInfo();
});
