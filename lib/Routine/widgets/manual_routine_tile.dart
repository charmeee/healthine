import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthin/Routine/models/routine_models.dart';

import '../../Common/Const/const.dart';
import '../../Dictionary/screens/main_dictionary_screen.dart';

final manualTileInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.white54);

class ManualTile extends StatefulWidget {
  final Function showDoingRoutineAlert;
  final bool recordEmpty;
  final bool isDoingRoutine;
  final MyRoutine myRoutine;
  final Function(List<RoutineManual>) setRoutineManauls;
  final bool editMode;
  final Function(ManualType type, int index, int value) setRoutineManualType;
  const ManualTile(
      {Key? key,
      required this.showDoingRoutineAlert,
      required this.recordEmpty,
      required this.isDoingRoutine,
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
            width: MediaQuery.of(context).size.width,
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
            trailing: widget.editMode
                ? IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                : null,
            subtitle: routineManual.isCardio
                ? _buildCardioRow(routineManual, index)
                : _buildWeightRow(routineManual, index),
          ),
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        if (widget.isDoingRoutine && !widget.recordEmpty) {
          widget.showDoingRoutineAlert();
        } else {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          log("oldIndex : $oldIndex , newIndex : $newIndex");
          //깊은 복사가 안되었어서 생긴문제 ㅎ;
          final _routineList = [...widget.myRoutine.routineManuals!];
          var item = _routineList.removeAt(oldIndex);
          _routineList.insert(newIndex, item);
          widget.setRoutineManauls(_routineList);
        }
      },
    );
  }

  Widget _buildCardioRow(RoutineManual routineManual, int index) {
    if (widget.isDoingRoutine && !widget.recordEmpty) {
      return SizedBox(
        height: 40,
        child: Row(
          children: [
            Text(
              " ${routineManual.playMinute}분",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              " ${routineManual.speed}속도",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 90,
          height: 50,
          child: TextField(
            controller: TextEditingController(
                text: routineManual.playMinute.toString()),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value == "") {
                value = "0";
              }
              widget.setRoutineManualType(
                  ManualType.playMinute, index, int.parse(value));
            },
            decoration: manualTileInputDecoration.copyWith(suffixText: "분"),
          ),
        ),
        SizedBox(
          width: 90,
          height: 50,
          child: TextField(
            controller: TextEditingController(
                text: routineManual.targetNumber.toString()),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value == "") {
                value = "0";
              }
              widget.setRoutineManualType(
                  ManualType.targetNumber, index, int.parse(value));
            },
            decoration: manualTileInputDecoration.copyWith(suffixText: "속도"),
          ),
        ),
      ],
    );
  }

  Widget _buildWeightRow(RoutineManual routineManual, int index) {
    if (widget.isDoingRoutine && !widget.recordEmpty) {
      return SizedBox(
        height: 40,
        child: Row(
          children: [
            Text(
              " ${routineManual.setNumber}세트",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              " ${routineManual.targetNumber}회",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              " ${routineManual.weight}kg",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 90,
          height: 50,
          child: TextField(
            controller:
                TextEditingController(text: routineManual.setNumber.toString()),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value == "") {
                value = "0";
              }
              widget.setRoutineManualType(
                  ManualType.setNumber, index, int.parse(value));
            },
            decoration: manualTileInputDecoration.copyWith(suffixText: "세트"),
          ),
        ),
        SizedBox(
          width: 90,
          height: 50,
          child: TextField(
            controller: TextEditingController(
                text: routineManual.targetNumber.toString()),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value == "") {
                value = "0";
              }
              widget.setRoutineManualType(
                  ManualType.targetNumber, index, int.parse(value));
            },
            decoration: manualTileInputDecoration.copyWith(suffixText: "회"),
          ),
        ),
        SizedBox(
          width: 90,
          height: 50,
          child: TextField(
            controller:
                TextEditingController(text: routineManual.weight.toString()),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              log(value);
              if (value == "") {
                value = "0";
              }
              widget.setRoutineManualType(
                  ManualType.weight, index, int.parse(value));
            },
            decoration: manualTileInputDecoration.copyWith(suffixText: "무게"),
          ),
        ),
      ],
    );
  }
}
