import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';
import 'package:healthin/Provider/routine_provider.dart';
import 'package:healthin/Provider/user_provider.dart';

import 'package:healthin/Screen/routineSetting/routineSetting_screen.dart';

class routineCard extends ConsumerStatefulWidget {
  const routineCard({Key? key}) : super(key: key);

  @override
  ConsumerState<routineCard> createState() => _routineCardState();
}

class _routineCardState extends ConsumerState<routineCard> {
  int _index = 0;

  // Future<List<RoutineData>> readJson() async {
  //   //json파일 읽어오기
  //   final String response =
  //       await rootBundle.loadString('testjsonfile/healthmachinedata.json');
  //   //print(response.runtimeType);w
  //   Map<String, dynamic> _alldata = await jsonDecode(response);
  //   log("키들 :" + _alldata.keys.toString());
  //   // List<RoutineData> _data = [
  //   //   ..._alldata["routineData"].map((item) => RoutineData.fromJson(item))
  //   // ];
  //   // log(_alldata.keys.toString());
  //   // log(_data[0].toString());
  //   setState(() {
  //     routineList = [
  //       ..._alldata["routineData"].map((item) => RoutineData.fromJson(item))
  //     ];
  //   });
  //   return routineList;
  // }
  //
  // List<RoutineData> routineList = [
  //   // {"type": "러닝머신", "count": "10분", "img": "assets/running mashin.png"},
  //   // {
  //   //   "type": "레그 익스텐션",
  //   //   "count": "10kg 10회 3세트",
  //   //   "img": "assets/Leg extension.png"
  //   // },
  //   // {"type": "레그 컬", "count": "20kg 10회 3세트", "img": "assets/leg curl.png"},
  //   // {
  //   //   "type": "스컬 크러셔",
  //   //   "count": "10kg 10회 3세트",
  //   //   "img": "assets/Skull Crusher.png"
  //   // },
  //   // {"type": "펙덱", "count": "10kg 15회 3세트", "img": "assets/Pec Deck .png"},
  // ];
  //
  // void changeRoutine(List Routine) {
  //   setState(() {
  //     routineList = [...Routine];
  //   });
  // }
  //
  // initState() {
  //   super.initState();
  //   readJson();
  // }

  @override
  Widget build(BuildContext context) {
    final routineListState = ref.watch(RoutineNotifierProvider);
    ref.listen(RoutineNotifierProvider,
        (List<RoutineData>? previousCount, List<RoutineData>? newCount) {
      log("웨안바뀜?");
      setState(() {
        _index = 0;
      });
    });
    log("빌드수");
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
