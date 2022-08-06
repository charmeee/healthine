import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Provider/exercisedata_provider.dart';
import '../../exercisewatch/whileExercise.dart';
import '../report.dart';
import 'Inbody/InbodyCard.dart';
import 'routine/routineCard.dart';

class Tab1 extends ConsumerWidget {
  Tab1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("홈텝빌드");
    var UserExercisedState = ref.watch(UserExercisedNotifierProvider);
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, //가로로 꽉차게
                  children: [
                routineCard(), //오늘의 루틴
                InbodyCard(), //인바디 차트

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "오늘 운동 기록",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (UserExercisedState.isEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("오늘의 운동기록이 없습니다.\n운동을 기록해보세요!"),
                          ),
                        ] else ...[
                          for (int i = 0;
                              i < UserExercisedState.length;
                              i++) ...[
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '${i + 1}. ${UserExercisedState[i].name}    ${UserExercisedState[i].totalnum}회  ${UserExercisedState[i].totalTime}초',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ))
                          ]
                        ],
                      ],
                    ),
                  ),
                ),
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
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WhileExercise(
                                    exerciseName: "바벨 스쿼트",
                                  )));
                    },
                    child: Text("카운터로 이동"))
              ]),
        ),
      ),
    );
  }
}
