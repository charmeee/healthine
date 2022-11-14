import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Routine/screens/routineSetting_screen.dart';

import '../../Common/util/util.dart';
import '../providers/routine_provider.dart';

class MyRoutineListTabLayout extends ConsumerWidget {
  const MyRoutineListTabLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myRoutineList = ref.watch(userRoutinePreviewProvider);

    return ListView.builder(
        itemCount: myRoutineList.length,
        itemBuilder: (context, index) {
          List<String> getDay = getDayList(myRoutineList[index].days);
          List<String> types =
              myRoutineList[index].types.map((e) => "#$e").toList();
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoutineSetting(
                            routine: myRoutineList[index],
                            routineTitle: myRoutineList[index].title,
                            isNew: false,
                          ))).then((value) {
                log("pop");
              });
            },
            child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                decoration: filledContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(myRoutineList[index].title.toString(),
                        style: h3Bold_18),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "요일 : " +
                              (getDay.isEmpty ? "없음" : getDay.join(" · ")),
                          style: bodyRegular_14,
                        ),
                        Text(
                          types.join(" "),
                          style: bodyRegular_14,
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
