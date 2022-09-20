// import 'dart:convert';
// import 'dart:developer';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:healthin/Provider/user_provider.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Provider/routine_provider.dart';
import 'package:healthin/Screen/exercisewatch/whileExercise.dart';
import 'package:healthin/Screen/routineSetting/routineSetting_screen.dart';

// final indexProvider = Provider<int>((ref) {
//   final routineListWatch = ref.watch(RoutineNotifierProvider);
//   int index = routineListWatch.indexWhere((element) => element.status == true);
//   if (index == -1) {
//     index = 0;
//   }
//   return index;
// });

class RoutineCard extends ConsumerStatefulWidget {
  const RoutineCard({Key? key}) : super(key: key);

  @override
  ConsumerState<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends ConsumerState<RoutineCard> {
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_index = ref.read(indexProvider);
  }

  @override
  Widget build(BuildContext context) {
    final routineListWatch = ref.watch(RoutineNotifierProvider);

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
              itemCount: routineListWatch.length,
              controller: PageController(viewportFraction: 0.7),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (BuildContext context, int index) {
                return Transform.scale(
                  scale: index == _index ? 1 : 0.9,
                  child: Card(
                    elevation: 6,
                    color:
                        routineListWatch[index].status != routineStatus.before
                            ? Colors.green[100]
                            : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          routineListWatch[index].img.toString(),
                          height: 170,
                        ),
                        Text(
                          routineListWatch[index].name.toString(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          routineListWatch[index].type.toString() == "유산소"
                              ? routineListWatch[index].totalTime.toString()
                              : "${routineListWatch[index].weight}kg ${routineListWatch[index].numPerSet}회 ${routineListWatch[index].totalSet}세트",
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
                log(routineListWatch[_index].status.toString());
                if (routineListWatch[_index].status == routineStatus.before) {
                  ref
                      .read(RoutineNotifierProvider.notifier)
                      .changeRoutineStatus(_index, routineStatus.doing);
                }
                if (routineListWatch[_index].status != routineStatus.done) {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => WhileExercise(
                  //               routineid: routineListWatch[_index].id,
                  //               userExerciseId:
                  //                   routineListWatch[_index].userExerciseId,
                  //               type: routineListWatch[_index].type,
                  //             )));
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.black54),
              child: Text("루틴 시작하기"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                //routineListWatch[index]
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RoutineSetting()));
              },
              style: ElevatedButton.styleFrom(primary: Colors.black54),
              child: Text("루틴 수정하기"),
            ),
          )
        ],
      ),
    );
  }
}
