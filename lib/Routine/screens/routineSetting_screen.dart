import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Routine/providers/routine_provider.dart';
import 'package:healthin/Dictionary/screens/main_dictionary_screen.dart';
import 'package:healthin/Routine/routine_models.dart';
import 'package:healthin/Routine/screens/routineAdding_screen.dart';

import '../../Common/util/util.dart';
import '../../Dictionary/providers/dictonary_provider.dart';
import '../../Record/screens/whileExercise.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.routine != null) {
      //이건 레퍼런스에서 가져온루틴 은 레퍼런스 가저오기 api가 있어서 무적건 get요청을 날리면될듯.

      //원래 있던 루틴.
      myRoutine = MyRoutine.fromJson(myRoutineEx); //futurebuilder로해도될듯^.^
      //get요청을조진다. => manaul부분이 절대 null이될 수 없음

    } else {
      //처음루틴을 만드는 경우.
      myRoutine = MyRoutine.init(widget.routineTitle); //manual부분 null
      //루틴 post를해서 루틴 id를 채워넣음.
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> type = myRoutine.type.map((e) => "#$e").toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.backspace),
        ),
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
                        onSelected: (bool value) {
                          if (value == true &&
                              ref.watch(dayOfWeekRoutineProvider)[i] != null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("이미 등록된 루틴이 있습니다."),
                                    content:
                                        Text("이미 등록된 루틴이 있습니다. 루틴을 변경하시겠습니까?"),
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
                            //걍여기잇는거에서바꾸기
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
            child: ReorderableListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: myRoutine.routineManuals!.length + 1,
              itemBuilder: (context, index) {
                if (index == myRoutine.routineManuals!.length) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: IconButton(
                          onPressed: () async {
                            List<RoutineManual> routineManuals =
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Dictionary(addmode: true)));
                            setState(() {
                              myRoutine.routineManuals!.addAll(routineManuals);
                            });
                          },
                          icon: Icon(Icons.add)),
                    ),
                  );
                }
                return Card(
                  //key: ValueKey(_routineList["type"]), 는 이름에따라서 키가 발급됨 만약 이름이 같으면 같은키
                  key: Key('$index'),
                  color: secondaryColor,
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      myRoutine.routineManuals![index].manualTitle,
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => RoutineAdding(index: index),
                      // );
                    },
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                //깊은 복사가 안되었어서 생긴문제 ㅎ;
                final _routineList = [...myRoutine.routineManuals!];
                var item = _routineList.removeAt(oldIndex);
                _routineList.insert(newIndex, item);
                setState(() {
                  myRoutine.routineManuals = _routineList;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () {
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
