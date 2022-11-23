import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:healthin/Dictionary/screens/dictionary_detail_screeen.dart';
import 'package:healthin/Dictionary/services/dictionary_api.dart';
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
  final routineFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: routineFormKey,
      child: ReorderableListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: widget.myRoutine.routineManuals!.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.myRoutine.routineManuals!.length) {
            return SizedBox(
              key: Key('$index'),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: primaryColor,
                  child: IconButton(
                      onPressed: () async {
                        if (widget.isDoingRoutine && !widget.recordEmpty) {
                          await widget.showDoingRoutineAlert();
                        } else {
                          List<RoutineManual> fromDictionary =
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Dictionary(addmode: true)));
                          widget.setRoutineManauls([
                            ...widget.myRoutine.routineManuals!,
                            ...fromDictionary
                          ]);
                        }
                      },
                      icon: Icon(Icons.add)),
                ),
              ),
            );
          }
          RoutineManual routineManual = widget.myRoutine.routineManuals![index];
          return Container(
            //key: ValueKey(_routineList["type"]), 는 이름에따라서 키가 발급됨 만약 이름이 같으면 같은키
            key: Key('$index'),
            color: Colors.black,
            padding: EdgeInsets.only(
                bottom: (index == widget.myRoutine.routineManuals!.length - 1)
                    ? 0
                    : 8),
            child: Container(
              color: backgroundColor,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              ManualData manualData =
                                  await getDictionaryByManualId(widget.myRoutine
                                      .routineManuals![index].manualId);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DictionaryDetail(
                                        founddata: manualData,
                                      )));
                            },
                            icon: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            routineManual.manualTitle,
                            style: bodyBold_16,
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            List<RoutineManual> tmp = [
                              ...widget.myRoutine.routineManuals!
                            ];
                            tmp.removeAt(index);
                            widget.setRoutineManauls(tmp);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: mediumGrayColor,
                          )),
                    ],
                  ),
                ),
                Divider(
                  color: darkGrayColor,
                  height: 10,
                ),
                routineManual.isCardio
                    ? _buildCardioRow(routineManual, index)
                    : _buildWeightRow(routineManual, index),
              ]),
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
      ),
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
              style: bodyRegular_16,
            ),
            Text(
              " ${routineManual.speed}속도",
              style: bodyRegular_16,
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
          child: TextFormField(
            style: bodyRegular_16,
            initialValue: routineManual.playMinute.toString(),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value == null) {
                value = "0";
              }
              widget.setRoutineManualType(
                  ManualType.playMinute, index, int.parse(value));
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                suffixText: "분",
                suffixStyle: bodyRegular_16),
          ),
        ),
        SizedBox(
          width: 90,
          height: 50,
          child: TextFormField(
            style: bodyRegular_16,
            initialValue: routineManual.targetNumber.toString(),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value == null) {
                value = "0";
              }
              widget.setRoutineManualType(
                  ManualType.targetNumber, index, int.parse(value));
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                suffixText: "속도",
                suffixStyle: bodyRegular_16),
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
              style: bodyRegular_16,
            ),
            Text(
              " ${routineManual.weight}kg",
              style: bodyRegular_16,
            ),
            Text(
              " ${routineManual.targetNumber}회",
              style: bodyRegular_16,
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 90,
            height: 50,
            child: TextFormField(
              style: bodyRegular_16,
              initialValue: routineManual.setNumber.toString(),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value == null) {
                  value = "0";
                }
                widget.setRoutineManualType(
                    ManualType.setNumber, index, int.parse(value));
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor)),
                  suffixText: "세트",
                  suffixStyle: bodyRegular_16),
            ),
          ),
          SizedBox(
            width: 90,
            height: 50,
            child: TextFormField(
              style: bodyRegular_16,
              initialValue: routineManual.weight.toString(),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                log(value);
                if (value == null) {
                  value = "0";
                }
                widget.setRoutineManualType(
                    ManualType.weight, index, int.parse(value));
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor)),
                  suffixText: "무게",
                  suffixStyle: bodyRegular_16),
            ),
          ),
          SizedBox(
            width: 90,
            height: 50,
            child: TextFormField(
              style: bodyRegular_16,
              initialValue: routineManual.targetNumber.toString(),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value == null) {
                  value = "0";
                }
                widget.setRoutineManualType(
                    ManualType.targetNumber, index, int.parse(value));
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor)),
                  suffixText: "회",
                  suffixStyle: bodyRegular_16),
            ),
          ),
        ],
      ),
    );
  }
}
