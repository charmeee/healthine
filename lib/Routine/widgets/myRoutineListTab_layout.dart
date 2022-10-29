import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      children: List.generate(myRoutineList.length, (index) {
        List<String> getDay = getDayList(myRoutineList[index].days);
        List<String> type =
            myRoutineList[index].type.map((e) => "#$e").toList();
        return GestureDetector(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoutineSetting(
                            routine: myRoutineList[index],
                            routineTitle: myRoutineList[index].title)))
                .then((value) {
              log("pop");
            });
          },
          child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            myRoutineList[index].title.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(type.join(" ")),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "요일: " + getDay.join(","),
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }
}
