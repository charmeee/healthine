import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/User/models/user_model.dart';
import 'package:healthin/User/providers/user_provider.dart';

class UserEditSetting extends ConsumerStatefulWidget {
  const UserEditSetting({Key? key}) : super(key: key);

  @override
  ConsumerState<UserEditSetting> createState() => _UserEditSettingState();
}

class _UserEditSettingState extends ConsumerState<UserEditSetting> {
  final formKey = GlobalKey<FormState>();
  late UserInfo changedInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changedInfo = ref.read(userProfileNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final _userinfo = ref.watch(userProfileNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.backspace),
        ),
        title: Text("내 정보관리"),
        backgroundColor: backgroundColor,
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
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        style: bodyRegular_16,
                        initialValue: _userinfo.nickname,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefix: Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Text(
                                "닉네임",
                                style: bodyRegular_14.copyWith(
                                    color: lightGrayColor),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '닉네임을 입력해주세요';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          changedInfo.nickname = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: bodyRegular_16,
                        initialValue: _userinfo.weight.toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefix: Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Text(
                                "몸무게",
                                style: bodyRegular_14.copyWith(
                                    color: lightGrayColor),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor))),
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {
                          changedInfo.weight = value!;
                        },
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      //나이
                      TextFormField(
                        style: bodyRegular_16,
                        initialValue: _userinfo.ageRange.toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefix: Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Text(
                                "나이",
                                style: bodyRegular_14.copyWith(
                                    color: lightGrayColor),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor))),
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {
                          changedInfo.ageRange = value!;
                        },
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 28.0),
                            child: Text("성별",
                                style: bodyRegular_14.copyWith(
                                    color: lightGrayColor)),
                          ),
                          ChoiceChip(
                            label: Text("남자"),
                            selected: changedInfo.gender == "man",
                            onSelected: (bool selected) {
                              changedInfo.gender = "man";
                            },
                            selectedColor: primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ChoiceChip(
                            label: Text("여자"),
                            selected: changedInfo.gender == "woman",
                            onSelected: (bool selected) {
                              changedInfo.gender = "woman";
                            },
                            selectedColor: primaryColor,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              bool result = await ref
                  .read(userProfileNotifierProvider.notifier)
                  .updateUserProfile(changedInfo);
              if (result) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("저장이 완료되었습니다"),
                  duration: Duration(seconds: 1),
                ));
                Navigator.of(context).pop();
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text("수정"),
        ),
      ),
    );
  }
}
