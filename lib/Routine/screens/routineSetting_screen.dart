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

class RoutineSetting extends ConsumerStatefulWidget {
  final Routine myRoutine;
  const RoutineSetting({
    Key? key,
    required this.myRoutine,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RoutineSettingState();
}

class _RoutineSettingState extends ConsumerState<RoutineSetting> {
  late Routine myRoutine;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myRoutine = widget.myRoutine;
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
                        selected: myRoutine.day[i] == 1,
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
                                            ref
                                                .read(userRoutineListProvider
                                                    .notifier)
                                                .editDayOfWeek(
                                                    myRoutine.id, i, value);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("변경"))
                                    ],
                                  );
                                });
                          } else {
                            ref
                                .read(userRoutineListProvider.notifier)
                                .editDayOfWeek(myRoutine.id, i, value);
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
              itemCount: myRoutine.routineManuals.length,
              itemBuilder: (context, index) {
                String name = ref
                    .read(DictionaryNotifierProvider.notifier)
                    .getDictionaryNameById(
                        myRoutine.routineManuals[index].manualId);
                return Card(
                  //key: ValueKey(_routineList["type"]), 는 이름에따라서 키가 발급됨 만약 이름이 같으면 같은키
                  key: Key('$index'),
                  color: secondaryColor,
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      name,
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
                final _routineList = [...myRoutine.routineManuals];
                var item = _routineList.removeAt(oldIndex);
                _routineList.insert(newIndex, item);
                //routineListRead.changeRoutineOrder(_routineList);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => WhileExercise(
            //             routine: widget.myRoutine.routineManuals,
            //             routineId: widget.myRoutine.id)));
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
