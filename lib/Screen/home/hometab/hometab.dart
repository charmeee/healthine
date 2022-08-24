import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Screen/report/report_screen.dart';
import 'Inbody/InbodyCard.dart';
import 'Todayexecise/todayExecisedCard.dart';
import 'routine/routineCard.dart';

class Tab1 extends ConsumerWidget {
  Tab1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("홈텝빌드");
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, //가로로 꽉차게
                  children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "이번주에 운동을 하지 않았어요..",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Text(
                          "운동을 시작해보세요!",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                routineCard(), //오늘의 루틴
                InbodyCard(), //인바디 차트
                ExecisedCard(),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(4),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black54),
                      child: const Text(
                        "리포트 보기",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Report()));
                      }),
                )
              ]),
        ),
      ),
    );
  }
}
