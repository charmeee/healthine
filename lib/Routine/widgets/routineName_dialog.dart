import 'dart:developer';

import 'package:flutter/material.dart';

import '../screens/routineSetting_screen.dart';

class NameInputDialog extends StatelessWidget {
  final GlobalKey<FormState> routineFormKey;
  final bool addMode;
  const NameInputDialog({
    Key? key,
    required this.routineFormKey,
    required this.addMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: addMode ? Text("루틴 추가") : Text("루틴 이름 변경"),
      content: TextFormField(
        onSaved: (value) async {
          log(value.toString());
          if (addMode) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RoutineSetting(routineTitle: value.toString())));
          } else {
            Navigator.pop(context, value.toString());
          }
        },
        decoration: InputDecoration(
          hintText: "루틴의 이름을 입력해주세요",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "루틴을 입력하세요";
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
              if (routineFormKey.currentState!.validate()) {
                log("루틴 이름추가");
                routineFormKey.currentState!.save();
              }
            },
            child: Text("확인")),
      ],
    );
  }
}
