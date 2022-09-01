import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Provider/routine_provider.dart';
import 'package:healthin/Provider/user_provider.dart';
import 'package:healthin/Screen/exercisewatch/whileExercise.dart';

import 'package:healthin/Screen/routineSetting/routineSetting_screen.dart';

class routineCard extends ConsumerStatefulWidget {
  const routineCard({Key? key}) : super(key: key);

  @override
  ConsumerState<routineCard> createState() => _routineCardState();
}

class _routineCardState extends ConsumerState<routineCard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final routineListState = ref.watch(RoutineNotifierProvider);
    ref.listen(RoutineNotifierProvider,
        (List<RoutineData>? previousCount, List<RoutineData>? newCount) {
      setState(() {
        _index = 0;
      });
    });
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: const Text(
              "오늘의 루틴",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 250,
            child: PageView.builder(
              itemCount: routineListState.length,
              controller: PageController(viewportFraction: 0.7),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (BuildContext context, int index) {
                return Transform.scale(
                  scale: index == _index ? 1 : 0.9,
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          routineListState[index].img.toString(),
                          height: 170,
                        ),
                        Text(
                          routineListState[index].name.toString(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          routineListState[index].type.toString() == "유산소"
                              ? routineListState[index].time.toString()
                              : "${routineListState[index].weight}kg ${routineListState[index].num}회 ${routineListState[index].set}세트",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WhileExercise(
                            routinedata: routineListState[_index])));
              },
              child: Text("루틴 시작하기"),
              style: ElevatedButton.styleFrom(primary: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                //routineListState[index]
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RoutineSetting()));
              },
              child: Text("루틴 수정하기"),
              style: ElevatedButton.styleFrom(primary: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
}
