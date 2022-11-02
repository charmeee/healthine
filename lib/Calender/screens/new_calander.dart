import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Record/models/exerciserecord_model.dart';
import 'package:healthin/Record/providers/exercisedata_provider.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Diet/models/diet_model.dart';
import '../../Diet/providers/diet_provider.dart';
import '../../Diet/services/diet_api.dart';
import '../../Record/services/record_api.dart';

const didhealthcolor = Colors.green;

class CalendarTab extends ConsumerStatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends ConsumerState<CalendarTab> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<Record>? exerciseRecords;
  DayDietStatistics? dietRecords;
  bool isToday() {
    return selectedDay.year == DateTime.now().year &&
        selectedDay.month == DateTime.now().month &&
        selectedDay.day == DateTime.now().day;
  }

  getLog() async {
    List<Record> records = await getRoutineLogByDay(
        DateFormat("yyyy-MM-dd").format(selectedDay).toString());
    DayDietStatistics? diet = await getDietStatistics(selectedDay);
    setState(() {
      exerciseRecords = records;
      dietRecords = diet;
    });
  }

  @override
  Widget build(BuildContext context) {
    final todayRecord = ref.watch(todayRecordProvider);
    final todayDiet = ref.watch(todayDietProvider);
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
                if (isToday() == false) {
                  getLog();
                }
              });
            },
            selectedDayPredicate: (DateTime date) {
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
              exerciseRecords: isToday() ? todayRecord : exerciseRecords,
              dietRecords: isToday() ? todayDiet : dietRecords,
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

//
// class RecordCalender extends ConsumerWidget {
//   RecordCalender({Key? key, required this.selectedDay}) : super(key: key);
//   final DateTime selectedDay;
//   List<Record>? exerciseRecords;
//   DayDietStatistics? dietRecords;
//
//   bool isToday() {
//     return selectedDay.year == DateTime.now().year &&
//         selectedDay.month == DateTime.now().month &&
//         selectedDay.day == DateTime.now().day;
//   }
//
//   getLog() async {
//     exerciseRecords = await getRoutineLogByDay(
//         DateFormat("yyyy-MM-dd").format(selectedDay).toString());
//     dietRecords = await getDietStatistics(selectedDay);
//     log("운동기록이 비어있나요?  : " + exerciseRecords!.isEmpty.toString());
//     log("운동기록이 비어있나요?  : " + exerciseRecords!.isEmpty.toString());
//     log("식단기록이 비어있나요?  : " + dietRecords!.meals.isEmpty.toString());
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     log("빌드여부 : ${selectedDay}");
//     if (isToday() == false) {
//       log("오늘아님");
//       getLog();
//     }
//     final todayRecord = ref.watch(todayRecordProvider);
//     final todayDiet = ref.watch(todayDietProvider);
//
//     if (isToday()) {
//       return todayDiet == null
//           ? const Center(
//               child: Text("로딩 중"),
//             )
//           : Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("운동기록"),
//                 todayRecord.isEmpty
//                     ? Text("운동기록이 없습니다.")
//                     : CalendarExerciseEvents(
//                         todayRecord: todayRecord,
//                       ),
//                 Text("식단 기록"),
//                 todayDiet.meals.isEmpty
//                     ? Text("식단기록이 없습니다.")
//                     : CalendarDietEvents(
//                         todayDiet: isToday() ? todayDiet : dietRecords!),
//               ],
//             );
//     } else {
//       return exerciseRecords == null
//           ? const Center(
//               child: Text("로딩 중"),
//             )
//           : Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("운동기록"),
//                 exerciseRecords!.isEmpty
//                     ? Text("운동기록이 없습니다.")
//                     : CalendarExerciseEvents(
//                         todayRecord: exerciseRecords!,
//                       ),
//                 Text("식단 기록"),
//                 (dietRecords!.meals.isEmpty)
//                     ? Text("식단기록이 없습니다.")
//                     : CalendarDietEvents(todayDiet: dietRecords!),
//               ],
//             );
//     }
//   }
// }
class RecordCalender extends StatelessWidget {
  const RecordCalender({Key? key, this.exerciseRecords, this.dietRecords})
      : super(key: key);
  final List<Record>? exerciseRecords;
  final DayDietStatistics? dietRecords;
  @override
  Widget build(BuildContext context) {
    log("빌드여부 : ${exerciseRecords} ${dietRecords}");
    return exerciseRecords == null || dietRecords == null
        ? const Center(
            child: Text("로딩 중"),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("운동기록"),
              exerciseRecords!.isEmpty
                  ? Text("운동기록이 없습니다.")
                  : CalendarExerciseEvents(
                      todayRecord: exerciseRecords!,
                    ),
              Text("식단 기록"),
              dietRecords!.meals.isEmpty
                  ? Text("식단기록이 없습니다.")
                  : CalendarDietEvents(todayDiet: dietRecords!),
            ],
          );
  }
}

//
// class RecordCalender extends ConsumerWidget {
//   final DateTime selectedDay;
//
//   const RecordCalender({Key? key, required this.selectedDay}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final todayRecord = ref.watch(todayRecordProvider);
//     final todayDiet = ref.watch(todayDietProvider);
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text("운동기록"),
//         selectedDay.year == DateTime.now().year &&
//                 selectedDay.month == DateTime.now().month &&
//                 selectedDay.day == DateTime.now().day
//             ? CalendarExerciseEvents(
//                 todayRecord: todayRecord,
//               )
//             : Text("운동기록이 없습니다."),
//         Text("식단기록"),
//         selectedDay.year == DateTime.now().year &&
//                 selectedDay.month == DateTime.now().month &&
//                 selectedDay.day == DateTime.now().day
//             ? CalendarDietEvents(todayDiet: todayDiet)
//             : Text("식단기록이 없습니다."),
//       ],
//     );
//   }
// }

class CalendarDietEvents extends StatelessWidget {
  final DayDietStatistics todayDiet;
  const CalendarDietEvents({Key? key, required this.todayDiet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${todayDiet.statistics.calories}kcal"),
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
            title: Text(todayRecord[index].startedAt.toString()),
            subtitle: Text(todayRecord[index].playMinute.toString()),
          );
        });
  }
}
