import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';
import 'package:healthin/Service/auth_request_api.dart';

final loginStateProvider = StateProvider<bool>((ref) => false);

//사용자 정보 조회
// {
// "id": "string",
// "username": "string",
// "name": "string",
// "nickname": "string",
// "avatarImage": "string",
// "phoneNumber": "string"
// }

final userState = StateProvider<UserInfo>((ref) {
  log("userState 변경");
  return UserInfo();
});
