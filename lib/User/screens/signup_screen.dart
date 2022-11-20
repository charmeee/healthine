import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/User/models/user_model.dart';

import '../providers/user_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUpScreen> {
  final _nicknameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late UserInfo userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(userProfileNotifierProvider.notifier).getUserProfile();
    userInfo = ref.read(userProfileNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "회원가입하기",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 100)),
            Center(
              child: Image.asset(
                "assets/splashicon.png",
                height: 100,
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      style: bodyRegular_16,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "닉네임 입력은 필수 사항입니다.",
                          hintStyle: bodyRegular_14,
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
                        userInfo.nickname = value!;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: bodyRegular_16,
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
                        userInfo.weight = value!;
                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //나이
                    TextFormField(
                      style: bodyRegular_16,
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
                        userInfo.ageRange = value!;
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
                          selected: userInfo.gender == "man",
                          onSelected: (bool selected) {
                            userInfo.gender = "man";
                          },
                          selectedColor: primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ChoiceChip(
                          label: Text("여자"),
                          selected: userInfo.gender == "woman",
                          onSelected: (bool selected) {
                            userInfo.gender = "woman";
                          },
                          selectedColor: primaryColor,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
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
                  .updateUserProfile(userInfo);
              if (result) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("회원가입 되었습니다"),
                  duration: Duration(seconds: 1),
                ));
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("회원가입에 실패되었습니다. 개발자에게 문의해주세요"),
                  duration: Duration(seconds: 1),
                ));
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text("시작하기"),
        ),
      ),
    );
  }
}
