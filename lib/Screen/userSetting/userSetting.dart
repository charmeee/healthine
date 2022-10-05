import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Const/const.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Model/user_model.dart';
import 'package:healthin/Provider/user_provider.dart';

class UserSetting extends ConsumerStatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  ConsumerState<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends ConsumerState<UserSetting> {
  final formKey = GlobalKey<FormState>();
  @override
  late UserInfo _userinfo;
  void initState() {
    // TODO: implement initState
    super.initState();
    _userinfo = ref.read(userProfileNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.backspace),
        ),
        title: Text("사용자 설정"),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _userinfo.nickname.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  // ListTile(
                  //   leading: Text("아이디"),
                  //   title: Text(_userinfo.username.toString()),
                  // ),
                  ListTile(
                    leading: Text("닉네임"),
                    title: Text(_userinfo.nickname.toString()),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("닉네임 변경"),
                                  content: TextFormField(
                                    onSaved: (value) {
                                      log(value.toString());
                                      ref
                                          .read(userProfileNotifierProvider
                                              .notifier)
                                          .updateUserProfile(value!);
                                    },
                                    decoration: InputDecoration(
                                      hintText: "변경할 닉네임을 입력하세요",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "닉네임을 입력하세요";
                                      }
                                      return null;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("취소")),
                                    TextButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text("확인")),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.edit)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("로그아웃"),
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
