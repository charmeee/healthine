import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Record/models/exerciserecord_model.dart';
import 'package:healthin/Record/screens/whileExercise.dart';

import '../../Common/screens/home_screen.dart';
import '../../Common/styles/buttonStyle.dart';
import '../models/routine_models.dart';
import '../screens/routineList_screen.dart';

class RoutineCard extends StatefulWidget {
  final MyRoutine? myRoutines;
  final List<Record> records;
  const RoutineCard({Key? key, required this.myRoutines, required this.records})
      : super(key: key);

  @override
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  int index = 0;
  String dettailData = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.myRoutines != null) {
      widget.myRoutines!.types.forEach((element) {
        dettailData += "$element · ";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("루틴카드 빌드");
    if (widget.myRoutines == null ||
        widget.myRoutines!.routineManuals == null ||
        widget.myRoutines!.routineManuals!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "오늘의 루틴이 없어요.\n 루틴을 설정해보세요.",
              style: h3Regular_18,
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: primaryButtonHeight,
              width: 240,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoutineList()),
                  );
                },
                child: Text("나만의 루틴 설정하기"),
                style: primaryButton,
              ),
            )
          ],
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoutineList()),
            );
          },
          child: SizedBox(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  decoration: borderContainer.copyWith(
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    children: [
                      Text(
                        DateTime.now().day.toString(),
                        style: h1Bold_24.copyWith(color: lightGrayColor),
                      ),
                      Text(
                        DateTime.now().year.toString() +
                            "." +
                            DateTime.now().month.toString(),
                        style:
                            captionRegular_12.copyWith(color: mediumGrayColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${widget.myRoutines!.routineManuals![index].weight} kg * ${widget.myRoutines!.routineManuals![index].targetNumber} 횟수 * ${widget.myRoutines!.routineManuals![index].setNumber} set",
                        style: bodyBold_14,
                      ),
                      Text(
                        dettailData,
                        style: bodyRegular_14,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (index >= widget.myRoutines!.routineManuals!.length - 1) {
                index = 0;
              } else {
                index++;
              }
            });
          },
          child: Container(
            height: 208,
            decoration: filledContainer,
            child: Stack(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 56,
                      width: 56,
                      color: Colors.grey,
                      child: Text("사진"),
                    ),
                    Text(
                      widget.myRoutines!.routineManuals![index].manualTitle,
                      style: h3Regular_18,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("완료",
                          style: bodyRegular_12.copyWith(color: primaryColor)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: mediumGrayColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                          "${index + 1}/${widget.myRoutines!.routineManuals!.length}",
                          style:
                              bodyRegular_12.copyWith(color: mediumGrayColor)),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
        SizedBox(
          height: primaryButtonHeight,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if (widget.myRoutines!.routineManuals != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WhileExercise(
                          routineManuals: widget.myRoutines!.routineManuals!,
                          routineId: widget.myRoutines!.id,
                          routineTitle: widget.myRoutines!.title)),
                );
              }
            },
            child: Text("운동 시작하기"),
            style: primaryButton,
          ),
        ),
      ],
    );
  }
}
