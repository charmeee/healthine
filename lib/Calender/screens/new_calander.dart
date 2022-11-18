import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Record/models/exerciserecord_model.dart';
import 'package:healthin/Record/providers/exercisedata_provider.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Common/styles/textStyle.dart';
import '../../Dictionary/providers/dictonary_provider.dart';
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
  PageController? pageController;
  bool floatingToggle = false;
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (floatingToggle)
            Container(
              width: 100,
              decoration: filledContainer.copyWith(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("💪 운동"),
                    style: ElevatedButton.styleFrom(
                        primary: secondaryColor, elevation: 0),
                  ),
                  Divider(
                    color: mediumGrayColor,
                    height: 1,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("💪 식단"),
                    style: ElevatedButton.styleFrom(
                        primary: secondaryColor, elevation: 0),
                  )
                ],
              ),
            ),
          if (floatingToggle)
            SizedBox(
              height: 16,
            ),
          FloatingActionButton(
            backgroundColor: floatingToggle ? secondaryColor : primaryColor,
            onPressed: () {
              setState(() {
                floatingToggle = !floatingToggle;
              });
            },
            child: floatingToggle
                ? SvgPicture.asset(
                    'assets/icons/close.svg',
                    width: 20,
                    height: 20,
                  )
                : Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 64,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "운동사전",
                    style: h1Bold_24,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          pageController?.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        },
                        //svg icon
                        icon: SvgPicture.asset(
                          'assets/icons/left.svg',
                          color: Colors.white,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      Text(
                        DateFormat("yyyy년 MM월").format(focusedDay).toString(),
                        style: bodyBold_16,
                      ),
                      IconButton(
                        onPressed: () {
                          pageController?.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/right.svg',
                          color: Colors.white,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.only(bottom: 12),
              child: TableCalendar(
                shouldFillViewport: true,
                onCalendarCreated: (controller) {
                  pageController = controller;
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    this.focusedDay = focusedDay;
                  });
                },
                locale: 'ko_KR',
                focusedDay: focusedDay,
                firstDay: DateTime(2020),
                lastDay: DateTime(2100),
                headerVisible: false,
                daysOfWeekHeight: 40,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: bodyBold_14,
                  weekendStyle: bodyBold_14,
                ),
                calendarStyle: CalendarStyle(
                  //cellPadding: EdgeInsets.symmetric(vertical: 4),
                  defaultTextStyle: bodyRegular_14,
                  outsideDaysVisible: false,
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
            ),
            Container(
              decoration: filledContainer,
              height: 96,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
            RecordCalender(
              exerciseRecords: isToday() ? todayRecord : exerciseRecords,
              dietRecords: isToday() ? todayDiet : dietRecords,
            ),
          ],
        ),
      ),
    );
  }
}

class RecordCalender extends StatelessWidget {
  const RecordCalender({Key? key, this.exerciseRecords, this.dietRecords})
      : super(key: key);
  final List<Record>? exerciseRecords;
  final DayDietStatistics? dietRecords;
  @override
  Widget build(BuildContext context) {
    log("빌드여부 : ${exerciseRecords} ${dietRecords}");
    if (exerciseRecords == null || dietRecords == null) {
      return Center(
        child: Text("로딩 중"),
      );
    }
    if (exerciseRecords!.isEmpty && dietRecords!.meals.isEmpty) {
      return Center(
        child: Text(
          "운동과 식단이 없습니다.\n운동과 식단을 추가해주세요.",
          textAlign: TextAlign.center,
          style: bodyRegular_16,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🍽  식단 기록",
            style: h3Bold_18,
          ),
          SizedBox(
            height: 8,
          ),
          dietRecords!.meals.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "식단기록이 없습니다.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : CalendarDietEvents(todayDiet: dietRecords!),
          Text(
            "💪  운동기록",
            style: h3Bold_18,
          ),
          SizedBox(
            height: 16,
          ),
          exerciseRecords!.isEmpty
              ? Text(
                  "운동기록이 없습니다.",
                  style: TextStyle(color: Colors.white),
                )
              : CalendarExerciseEvents(
                  todayRecord: exerciseRecords!,
                ),
        ],
      ),
    );
  }
}

class CalendarDietEvents extends StatelessWidget {
  final DayDietStatistics todayDiet;
  const CalendarDietEvents({Key? key, required this.todayDiet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${todayDiet.statistics.calories}kcal",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class CalendarExerciseEvents extends ConsumerWidget {
  final List<Record> todayRecord;
  const CalendarExerciseEvents({Key? key, required this.todayRecord})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: borderContainer,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: todayRecord.length,
          itemBuilder: (context, index) {
            log("달력");
            log(todayRecord[index].manualId.toString());
            // String? exName = ref
            //     .read(dictionaryNotifierProvider.notifier)
            //     .getDictionaryNameById(todayRecord[index].manualId.toString());
            return ListTile(
              title: Text(
                todayRecord[index].manualId.toString(),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                todayRecord[index].playMinute.toString() + "분",
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
    );
  }
}
