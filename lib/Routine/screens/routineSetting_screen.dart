import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Routine/providers/routine_provider.dart';
import 'package:healthin/Dictionary/screens/main_dictionary_screen.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/Routine/screens/routineAdding_screen.dart';

import '../../Common/util/util.dart';
import '../../Dictionary/providers/dictonary_provider.dart';
import '../../Record/screens/whileExercise.dart';
import '../services/myRoutine_api.dart';
import '../test.dart';

class RoutineSetting extends ConsumerStatefulWidget {
  final MyRoutine? routine;
  final String routineTitle;
  const RoutineSetting({
    Key? key,
    this.routine,
    required this.routineTitle,
    //routineid를받고 is null이면 추가 아니면 수정.
  }) : super(key: key);

  @override
  ConsumerState createState() => _RoutineSettingState();
}

class _RoutineSettingState extends ConsumerState<RoutineSetting> {
  late MyRoutine myRoutine;
  late MyRoutine copyRoutine; //비교하기위한 복제본.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.routine == null
        ? (myRoutine = MyRoutine.init(widget.routineTitle))
        : (myRoutine = widget.routine!);
    widget.routine == null ? postRoutine() : getRoutine();
  }

  getRoutine() async {
    MyRoutine routine = await getMyRoutineById(widget.routine!.id);
    setState(() {
      myRoutine = MyRoutine.copyWith(routine);
      copyRoutine = MyRoutine.copyWith(routine);
    });
  }

  postRoutine() async {
    MyRoutine routine = await postMyRoutine(myRoutine);
    setState(() {
      myRoutine = MyRoutine.copyWith(routine);
      copyRoutine = MyRoutine.copyWith(routine);
    });
  }

  sendRoutine() async {
    List<RoutineManual> beforeManual = [...copyRoutine.routineManuals!];
    log("sendRoutine");
    log("beforeManual : ${copyRoutine.routineManuals!.length}, myRoutine : ${myRoutine.routineManuals!.length}");
    for (RoutineManual nowManual in myRoutine.routineManuals!) {
      int index = beforeManual.indexWhere(
          (element) => element.routineManualId == nowManual.routineManualId);
      if (index > -1) {
        //값이있는것.patch를 날릴 것.
        beforeManual.removeAt(index);
        //patch e
      } else {
        await postMyRoutineManual(nowManual, myRoutine.id);
        //post e
      }
    }
    if (beforeManual.isNotEmpty) {
      for (RoutineManual beforeManual in beforeManual) {
        await deleteMyRoutineManual(beforeManual.routineManualId);
      }
    }
    ref.read(userRoutinePreviewProvider.notifier).getRoutineData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //여기엔 패치?를 넣어야하나..봄?
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> type = myRoutine.type.map((e) => "#$e").toList();
    return WillPopScope(
      onWillPop: () async {
        await sendRoutine();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(myRoutine.title),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete))
          ],
          backgroundColor: primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  "요일",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            Container(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 7; i++) ...[
                      ChoiceChip(
                          label: Text(dayList[i]),
                          selected: myRoutine.days[i] == 1,
                          selectedColor: Colors.indigo,
                          onSelected: (bool value) {
                            if (value == true &&
                                ref.watch(dayOfWeekRoutineProvider)[i] !=
                                    null) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("이미 등록된 루틴이 있습니다."),
                                      content: Text(
                                          "이미 등록된 루틴이 있습니다. 루틴을 변경하시겠습니까?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("취소")),
                                        TextButton(
                                            onPressed: () {
                                              //그전루틴 patch
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("변경"))
                                      ],
                                    );
                                  });
                            } else {
                              setState(() {
                                myRoutine.days[i] = value ? 1 : 0;
                              });
                            }
                          })
                    ]
                  ]),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                "태그 : " + type.join(" "),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
                child: myRoutine.routineManuals != null
                    ? ReorderableListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
                        itemCount: myRoutine.routineManuals!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == myRoutine.routineManuals!.length) {
                            return Container(
                              key: Key('$index'),
                              height: 50,
                              child: Center(
                                child: IconButton(
                                    onPressed: () async {
                                      List<RoutineManual> fromDictionary =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Dictionary(
                                                          addmode: true)));
                                      setState(() {
                                        myRoutine.routineManuals = [
                                          ...myRoutine.routineManuals!,
                                          ...fromDictionary
                                        ];
                                      });
                                    },
                                    icon: Icon(Icons.add)),
                              ),
                            );
                          }
                          RoutineManual routineManual =
                              myRoutine.routineManuals![index];
                          return Card(
                            //key: ValueKey(_routineList["type"]), 는 이름에따라서 키가 발급됨 만약 이름이 같으면 같은키
                            key: Key('$index'),
                            color: secondaryColor,
                            elevation: 1,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: Text(
                                routineManual.manualTitle,
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: routineManual.isCardio
                                  ? Text(routineManual.playMinute.toString())
                                  : Text(routineManual.weight.toString() +
                                      "kg /" +
                                      routineManual.setNumber.toString() +
                                      "세트 /" +
                                      routineManual.targetNumber.toString() +
                                      "회"),
                            ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          log("oldIndex : $oldIndex , newIndex : $newIndex");
                          //깊은 복사가 안되었어서 생긴문제 ㅎ;
                          final _routineList = [...myRoutine.routineManuals!];
                          var item = _routineList.removeAt(oldIndex);
                          _routineList.insert(newIndex, item);
                          setState(() {
                            myRoutine.routineManuals = _routineList;
                          });
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () async {
              //일단 patch 나포스트먼저 시킴
              if (myRoutine.routineManuals == null ||
                  myRoutine.routineManuals!.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("루틴이 비어있습니다."),
                        content: Text("루틴을 추가해주세요."),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("확인"))
                        ],
                      );
                    });
              } else {
                await sendRoutine();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WhileExercise(
                            routineManuals: myRoutine.routineManuals!,
                            routineId: myRoutine.id,
                            routineTitle: myRoutine.title)));
              }
            },
            child: Text("루틴시작하기")),
      ),
    );
  }
}

// bottomNavigationBar: IconButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Dictionary(addmode: true)));
// },
// icon: Icon(Icons.add)),
