import 'dart:developer';

import 'package:flutter/material.dart';

import '../screens/routineSetting_screen.dart';

class NameInputDialog extends StatelessWidget {
  final GlobalKey<FormState> routineFormKey;
  final bool hasReference;
  const NameInputDialog({
    Key? key,
    required this.routineFormKey,
    required this.hasReference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: hasReference ? Text("루틴 이름 변경") : Text("루틴 추가"),
      content: TextFormField(
        onSaved: (value) async {
          log(value.toString());
          if (hasReference) {
            Navigator.pop(context, value.toString());
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => RoutineSetting(
                          routineTitle: value.toString(),
                          isNew: true,
                        )));
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
