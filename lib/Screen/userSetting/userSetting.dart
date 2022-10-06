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
          Column(
            children: [
              ListTile(
                leading: Text("닉네임"),
                title: Text(_userinfo.nickname.toString()),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Form(
                              key: formKey,
                              child: AlertDialog(
                                title: Text("닉네임 변경"),
                                content: TextFormField(
                                  onSaved: (value) async {
                                    log(value.toString());
                                    if (await ref
                                        .read(userProfileNotifierProvider
                                            .notifier)
                                        .updateUserProfile(value!)) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "변경할 닉네임을 입력하세요",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "닉네임을 입력하세요";
                                    }
                                    if (value.length > 10) {
                                      return "닉네임은 10자 이하로 입력하세요";
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
                                        if (formKey.currentState!.validate()) {
                                          log("닉네임 변경");
                                          formKey.currentState!.save();
                                          //Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text("확인")),
                                ],
                              ),
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
          )
        ],
      ),
    );
  }
}
