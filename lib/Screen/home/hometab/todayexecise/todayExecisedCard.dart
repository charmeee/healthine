import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/exercisedata_provider.dart';

class ExecisedCard extends ConsumerWidget {
  const ExecisedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("카드텝빌드");
    final UserExercisedState = ref.watch(UserExercisedNotifierProvider);
    log(UserExercisedState.runtimeType.toString());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "오늘 운동 기록",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            if (UserExercisedState.isEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("오늘의 운동기록이 없습니다.\n운동을 기록해보세요!"),
              ),
            ] else ...[
              for (int i = 0; i < UserExercisedState.length; i++) ...[
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
    );
  }
}