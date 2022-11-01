import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Record/models/exerciserecord_model.dart';
import 'package:healthin/Record/providers/exercisedata_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Diet/models/diet_model.dart';
import '../../Diet/providers/diet_provider.dart';

const didhealthcolor = Colors.green;

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('운동달력'),
        backgroundColor: Color(0xffFF24292f),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ko_KR',
            focusedDay: focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            calendarStyle: CalendarStyle(
              outsideDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              //markersColor: didhealthcolor,
            ),
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = selectedDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              log(selectedDay.toString());
              log(date.toString());
              return date.year == selectedDay.year &&
                  date.month == selectedDay.month &&
                  date.day == selectedDay.day;
            },
          ),
          Container(
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("하체", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          Expanded(
            child: RecordCalender(
              selectedDay: selectedDay,
            ),
            // child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //       return CalendarEvents(selectedDay:selectedDay);
            //     }),
          ),
        ],
      ),
    );
  }
}

class RecordCalender extends ConsumerWidget {
  final DateTime selectedDay;

  const RecordCalender({Key? key, required this.selectedDay}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayRecord = ref.watch(todayRecordProvider);
    final todayDiet = ref.watch(todayDietProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("운동기록"),
        selectedDay.year == DateTime.now().year &&
                selectedDay.month == DateTime.now().month &&
                selectedDay.day == DateTime.now().day
            ? CalendarExerciseEvents(
                todayRecord: todayRecord,
              )
            : Text("운동기록이 없습니다."),
        Text("식단기록"),
        selectedDay.year == DateTime.now().year &&
                selectedDay.month == DateTime.now().month &&
                selectedDay.day == DateTime.now().day
            ? CalendarDietEvents(todayDiet: todayDiet)
            : Text("식단기록이 없습니다."),
      ],
    );
  }
}

class CalendarDietEvents extends StatelessWidget {
  final DayDietStatistics? todayDiet;
  const CalendarDietEvents({Key? key, required this.todayDiet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todayDiet == null) {
      return Text("식단기록이 없습니다.");
    }
    return ListTile(
      title: Text(todayDiet!.statistics.calories.toString() + "kcal"),
    );
  }
}

class CalendarExerciseEvents extends StatelessWidget {
  final List<Record> todayRecord;
  const CalendarExerciseEvents({Key? key, required this.todayRecord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: todayRecord.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todayRecord[index].routineTitle),
            subtitle: Text(todayRecord[index].playMinute.toString()),
          );
        });
    // return Card(
    //   child: Container(
    //     height: 70,
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Container(
    //             alignment: Alignment.center,
    //             color: Colors.orange,
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //               child: Text(
    //                 "하체",
    //                 style: TextStyle(
    //                     color: Colors.white, fontWeight: FontWeight.bold),
    //               ),
    //             )),
    //         Expanded(
    //             child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: 1,
    //               ),
    //               Text(
    //                 "랫 풀 다운",
    //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //               ),
    //               Text(
    //                 "5kg * 10회 * 3세트",
    //                 style: TextStyle(fontSize: 17),
    //               ),
    //             ],
    //           ),
    //         )),
    //         Container(
    //           padding: const EdgeInsets.all(8.0),
    //           alignment: Alignment.bottomRight,
    //           child: Text(
    //             "00:20:10",
    //             style: TextStyle(fontSize: 16),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
