import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthin/Routine/models/routine_models.dart';

import '../../Common/Const/const.dart';
import '../../Dictionary/screens/main_dictionary_screen.dart';

class ManualTile extends StatefulWidget {
  final Function showDoingRoutineAlert;
  final bool recordEmpty;
  final MyRoutine myRoutine;
  final Function(List<RoutineManual>) setRoutineManauls;
  final bool editMode;
  final Function(ManualType type, int index, int value) setRoutineManualType;
  const ManualTile(
      {Key? key,
      required this.showDoingRoutineAlert,
      required this.recordEmpty,
      required this.myRoutine,
      required this.setRoutineManauls,
      required this.editMode,
      required this.setRoutineManualType})
      : super(key: key);

  @override
  State<ManualTile> createState() => _ManualTileState();
}

class _ManualTileState extends State<ManualTile> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      itemCount: widget.myRoutine.routineManuals!.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.myRoutine.routineManuals!.length) {
          return Container(
            key: Key('$index'),
            height: 50,
            child: Center(
              child: IconButton(
                  onPressed: () async {
                    if (widget.recordEmpty) {
                      List<RoutineManual> fromDictionary = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dictionary(addmode: true)));
                      widget.setRoutineManauls([
                        ...widget.myRoutine.routineManuals!,
                        ...fromDictionary
                      ]);
                    } else {
                      await widget.showDoingRoutineAlert();
                    }
                  },
                  icon: Icon(Icons.add)),
            ),
          );
        }
        RoutineManual routineManual = widget.myRoutine.routineManuals![index];
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
        if (widget.recordEmpty) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          log("oldIndex : $oldIndex , newIndex : $newIndex");
          //깊은 복사가 안되었어서 생긴문제 ㅎ;
          final _routineList = [...widget.myRoutine.routineManuals!];
          var item = _routineList.removeAt(oldIndex);
          _routineList.insert(newIndex, item);
          widget.setRoutineManauls(_routineList);
        } else {
          widget.showDoingRoutineAlert();
        }
      },
    );
  }
}
