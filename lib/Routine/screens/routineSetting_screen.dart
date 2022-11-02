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
import '../../Record/providers/exercisedata_provider.dart';
import '../../Record/screens/whileExercise.dart';
import '../services/myRoutine_api.dart';
import '../test.dart';
import '../widgets/manual_routine_tile.dart';
import '../widgets/routineName_dialog.dart';

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
  bool editMode = false;
  bool fixable = false;
  late TextEditingController titleController;
  int todayIndex = DateTime.now().weekday - 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.routineTitle);
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

  editRoutineTitle(String title) async {
    setState(() {
      myRoutine.title = title;
    });
    await patchMyRoutine(myRoutine.titleToJson(), myRoutine.id);
  }

  showDoingRoutineAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("루틴이 진행 중 임으로 루틴을 변경할 수 없습니다."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> editRoutineDay(int index, value) async {
    //참이면 바꼇고 참이아니면안바꼇고
    //1. 수정하고 싶은요일을 받는다.
    //원래 그요일에 무언
    if (value) {
      //곂칠때 대비한사전작업
      List<String?> days = ref.watch(dayOfWeekRoutineProvider);
      if (days[index] != null) {
        //바꿀려고햇는데 원래루틴이있을때
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("이미 등록된 루틴이 있습니다."),
                content: Text("이미 등록된 루틴이 있습니다. 루틴을 변경하시겠습니까?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text("취소")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text("변경"))
                ],
              );
            }).then((result) {
          if (result == false) {
            return false;
          }
        });
        //이전루틴 그날짜를 지운다.
        List<int> tmp = days.map((e) => e == days[index] ? 1 : 0).toList();
        tmp[index] = 0; //그날은 다시지워줌.
        await patchMyRoutine({"days": tmp}, days[index]!);
      }
      ref.watch(dayOfWeekRoutineProvider.notifier).state[index] =
          myRoutine.id; //원래루틴이없을때
    } else {
      //값이 value false일때
      ref.watch(dayOfWeekRoutineProvider.notifier).state[index] = null;
    }
    setState(() {
      myRoutine.days[index] = value ? 1 : 0;
    });
    await patchMyRoutine(myRoutine.dayToJson(), myRoutine.id);
    return true;
  }

  sendRoutineManuals() async {
    List<RoutineManual> beforeManual = [...copyRoutine.routineManuals!];
    log("sendRoutine");
    log("beforeManual : ${copyRoutine.routineManuals!.length}, myRoutine : ${myRoutine.routineManuals!.length}");
    int order = 0;
    for (RoutineManual nowManual in myRoutine.routineManuals!) {
      nowManual.order = order; //순서를 넣어준다.
      order++;
      //여기선 그전것과 비교해서 없으면 추가 있으면 수정 없어졌으면 삭제.
      int index = beforeManual.indexWhere(
          (element) => element.routineManualId == nowManual.routineManualId);
      if (index > -1) {
        //값이있는것.patch를 날릴 것.
        beforeManual.removeAt(index);
        patchMyRoutineManual(nowManual);
      } else {
        await postMyRoutineManual(nowManual, myRoutine.id);
      }
    }
    if (beforeManual.isNotEmpty) {
      for (RoutineManual beforeManual in beforeManual) {
        await deleteMyRoutineManual(beforeManual.routineManualId);
      }
    }
    ref.read(userRoutinePreviewProvider.notifier).getRoutineData();
  }

  setRoutineManauls(List<RoutineManual> list) {
    setState(() {
      myRoutine.routineManuals = list;
    });
  }

  setRoutineManualType(ManualType type, int index, int value) {
    switch (type) {
      case ManualType.playMinute:
        setState(() {
          myRoutine.routineManuals![index].playMinute = value;
        });
        break;
      case ManualType.weight:
        setState(() {
          myRoutine.routineManuals![index].weight = value;
        });
        break;
      case ManualType.targetNumber:
        setState(() {
          myRoutine.routineManuals![index].targetNumber = value;
        });
        break;
      case ManualType.setNumber:
        setState(() {
          myRoutine.routineManuals![index].setNumber = value;
        });
        break;
      case ManualType.speed:
        setState(() {
          myRoutine.routineManuals![index].speed = value;
        });
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> type = myRoutine.types.map((e) => "#$e").toList();
    final record = ref.watch(todayRecordProvider);
    final dayRoutine = ref.watch(dayOfWeekRoutineProvider);
    return WillPopScope(
      onWillPop: () async {
        if (myRoutine.id == dayRoutine[todayIndex] && record.isNotEmpty) {
          //이게 오늘의 루틴이고 기록중이면
          return true;
        }
        await sendRoutineManuals();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: editMode
              ? TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.white),
                )
              : Text(myRoutine.title),
          actions: [
            editMode
                ? IconButton(
                    //savebutton
                    onPressed: () {
                      setState(() {
                        myRoutine.title = titleController.text;
                        editMode = false;
                      });
                    },
                    icon: Icon(Icons.save),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        editMode = true;
                      });
                    },
                    icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () async {
                  await deleteMyRoutine(myRoutine.id);
                  ref
                      .read(userRoutinePreviewProvider.notifier)
                      .getRoutineData();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete))
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
                            if (DateTime.now().weekday - 1 == i &&
                                record.isNotEmpty) {
                              //
                              showDoingRoutineAlert();
                            } else {
                              editRoutineDay(i, value);
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
                    ? ManualTile(
                        setRoutineManauls: setRoutineManauls,
                        recordEmpty: record.isEmpty,
                        showDoingRoutineAlert: showDoingRoutineAlert,
                        myRoutine: myRoutine,
                        editMode: editMode,
                        setRoutineManualType: setRoutineManualType,
                        isDoingRoutine: dayRoutine[todayIndex] == myRoutine.id,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () async {
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
                if (dayRoutine[todayIndex] == myRoutine.id) {
                  //오늘의 루틴이다.
                  if (record.isEmpty) {
                    //오늘의 루틴이지만 기록이 없다.
                    await sendRoutineManuals();
                  }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WhileExercise(
                              routineManuals: myRoutine.routineManuals!,
                              routineId: myRoutine.id,
                              routineTitle: myRoutine.title)),
                      (route) => route.isFirst);
                } else {
                  //오늘의 루틴이 아니다.
                  if (record.isEmpty) {
                    //오늘의 루틴이 아니지만 기록이 없다.
                    if (await editRoutineDay(todayIndex, true)) {
                      await sendRoutineManuals();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WhileExercise(
                                  routineManuals: myRoutine.routineManuals!,
                                  routineId: myRoutine.id,
                                  routineTitle: myRoutine.title)),
                          (route) => route.isFirst);
                    }
                  } else {
                    showDoingRoutineAlert();
                  }
                }
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
