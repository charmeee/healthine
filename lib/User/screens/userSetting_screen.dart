import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/User/models/user_model.dart';
import 'package:healthin/User/providers/user_provider.dart';

class UserSetting extends ConsumerStatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  ConsumerState<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends ConsumerState<UserSetting> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserInfo _userinfo = ref.watch(userProfileNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.backspace),
        ),
        title: Text("내 프로필"),
        backgroundColor: backgroundColor,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "수정",
                style: bodyBold_16.copyWith(color: primaryColor),
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: darkGrayColor,
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _userinfo.nickname.toString(),
                    style: h1Regular_24.copyWith(fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.white,
                  height: 12,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Text(
                        "나이",
                        style: bodyRegular_14.copyWith(color: lightGrayColor),
                      ),
                      title: Text(
                        (_userinfo.ageRange ?? "입력된 정보 없음").toString(),
                        style: bodyRegular_16,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "몸무게",
                        style: bodyRegular_14.copyWith(color: lightGrayColor),
                      ),
                      title: Text(
                        (_userinfo.weight ?? "입력된 정보 없음").toString(),
                        style: bodyRegular_16,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "성별",
                        style: bodyRegular_14.copyWith(color: lightGrayColor),
                      ),
                      title: Text(
                        (_userinfo.gender ?? "입력된 정보 없음").toString(),
                        style: bodyRegular_16,
                      ),
                    ),
                    // ListTile(
                    //   leading: Text(
                    //     "닉네임",
                    //     style: bodyRegular_16,
                    //   ),
                    //   title: Text(
                    //     _userinfo.nickname.toString(),
                    //     style: bodyRegular_16,
                    //   ),
                    //   trailing: IconButton(
                    //       onPressed: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) {
                    //               return Form(
                    //                 key: formKey,
                    //                 child: AlertDialog(
                    //                   title: Text("닉네임 변경"),
                    //                   content: TextFormField(
                    //                     onSaved: (value) async {
                    //                       log(value.toString());
                    //                       if (await ref
                    //                           .read(userProfileNotifierProvider
                    //                               .notifier)
                    //                           .updateUserProfile(value!)) {
                    //                         Navigator.of(context).pop();
                    //                       }
                    //                     },
                    //                     decoration: InputDecoration(
                    //                       hintText: "변경할 닉네임을 입력하세요",
                    //                     ),
                    //                     validator: (value) {
                    //                       if (value == null || value.isEmpty) {
                    //                         return "닉네임을 입력하세요";
                    //                       }
                    //                       if (value.length > 10) {
                    //                         return "닉네임은 10자 이하로 입력하세요";
                    //                       }
                    //                       return null;
                    //                     },
                    //                   ),
                    //                   actions: [
                    //                     TextButton(
                    //                         onPressed: () {
                    //                           Navigator.of(context).pop();
                    //                         },
                    //                         child: Text("취소")),
                    //                     TextButton(
                    //                         onPressed: () {
                    //                           if (formKey.currentState!
                    //                               .validate()) {
                    //                             log("닉네임 변경");
                    //                             formKey.currentState!.save();
                    //                             //Navigator.of(context).pop();
                    //                           }
                    //                         },
                    //                         child: Text("확인")),
                    //                   ],
                    //                 ),
                    //               );
                    //             });
                    //       },
                    //       icon: Icon(Icons.edit)),
                    // ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: filledContainer,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "푸시알림 허용",
                        style: bodyRegular_16,
                      ),
                      Spacer(),
                      Switch(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: borderContainer.copyWith(
                      border: Border.all(color: primaryColor)),
                  width: double.infinity,
                  height: 64,
                  child: Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await ref
                            .read(userProfileNotifierProvider.notifier)
                            .logout();
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text(
                        "로그아웃",
                        style: bodyBold_16.copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        "탈퇴하기",
                        style: bodyRegular_16.copyWith(color: mediumGrayColor),
                      ),
                      IconButton(
                          onPressed: () async {
                            await ref
                                .read(userProfileNotifierProvider.notifier)
                                .deleteUserProfile();
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/right.svg",
                            color: mediumGrayColor,
                          ))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
