import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Record/models/exerciserecord_model.dart';
import 'package:healthin/Record/providers/exercisedata_provider.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/Routine/services/myRoutine_api.dart';
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
      // floatingActionButton: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     if (floatingToggle)
      //       Container(
      //         width: 100,
      //         decoration: filledContainer.copyWith(
      //             color: secondaryColor,
      //             borderRadius: BorderRadius.circular(10)),
      //         padding: const EdgeInsets.symmetric(horizontal: 8),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             ElevatedButton(
      //               onPressed: () {},
      //               child: Text("💪 운동"),
      //               style: ElevatedButton.styleFrom(
      //                   backgroundColor: secondaryColor, elevation: 0),
      //             ),
      //             Divider(
      //               color: mediumGrayColor,
      //               height: 1,
      //             ),
      //             ElevatedButton(
      //               onPressed: () {},
      //               child: Text("💪 식단"),
      //               style: ElevatedButton.styleFrom(
      //                   backgroundColor: secondaryColor, elevation: 0),
      //             )
      //           ],
      //         ),
      //       ),
      //     if (floatingToggle)
      //       SizedBox(
      //         height: 16,
      //       ),
      //     FloatingActionButton(
      //       backgroundColor: floatingToggle ? secondaryColor : primaryColor,
      //       onPressed: () {
      //         setState(() {
      //           floatingToggle = !floatingToggle;
      //         });
      //       },
      //       child: floatingToggle
      //           ? SvgPicture.asset(
      //               'assets/icons/close.svg',
      //               width: 20,
      //               height: 20,
      //             )
      //           : Icon(Icons.add),
      //     )
      //   ],
      // ),
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
            PointBar(
              exerciseRecords: isToday() ? todayRecord : exerciseRecords,
              dietRecords: isToday() ? todayDiet : dietRecords,
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

class PointBar extends StatelessWidget {
  final List<Record>? exerciseRecords;
  final DayDietStatistics? dietRecords;
  const PointBar({Key? key, this.exerciseRecords, this.dietRecords})
      : super(key: key);

  String getTotalTime(List<Record> records) {
    int total = 0;
    for (var element in records) {
      total += element.playMinute;
    }
    return "$total 분";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: filledContainer,
      height: 96,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/dumbbell.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  Text(" 운동개수", style: bodyRegular_16)
                ],
              ),
              Text(
                "${exerciseRecords?.length ?? 0}개",
                style: bodyBold_16,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/time.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  Text(" 운동시간", style: bodyRegular_16)
                ],
              ),
              Text(
                exerciseRecords == null ? "0분" : getTotalTime(exerciseRecords!),
                style: bodyBold_16,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/food.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  Text(
                    " 식단",
                    style: bodyRegular_16,
                  )
                ],
              ),
              Text(
                dietRecords == null ? "0개" : "${dietRecords!.meals.dietCount}개",
                style: bodyBold_16,
              )
            ],
          ),
        ],
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
          SizedBox(
            height: 16,
          ),
          Text(
            "💪  운동기록",
            style: h3Bold_18,
          ),
          SizedBox(
            height: 8,
          ),
          exerciseRecords!.isEmpty
              ? Center(
                  child: Text(
                    "운동기록이 없습니다.",
                    style: TextStyle(color: Colors.white),
                  ),
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
    return Container(
      decoration: borderContainer,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (todayDiet.meals.breakfast.isNotEmpty)
            DietTile(
              timeName: "아침",
              dietDetailResults: todayDiet.meals.breakfast,
            ),
          if (todayDiet.meals.lunch.isNotEmpty)
            DietTile(
              timeName: "점심",
              dietDetailResults: todayDiet.meals.lunch,
            ),
          if (todayDiet.meals.dinner.isNotEmpty)
            DietTile(
              timeName: "저녁",
              dietDetailResults: todayDiet.meals.dinner,
            ),
          if (todayDiet.meals.snack.isNotEmpty)
            DietTile(
              timeName: "간식",
              dietDetailResults: todayDiet.meals.snack,
            ),
        ],
      ),
    );
  }
}

class DietTile extends StatelessWidget {
  final String timeName;
  final List<DietDetailResult> dietDetailResults;
  const DietTile(
      {Key? key, required this.timeName, required this.dietDetailResults})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              timeName,
              style: bodyBold_16,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "${dietDetailResults.fold(0, (int sum, element) => sum! + (element.calories ?? 0).toInt())}kcal",
              style: bodyRegular_14.copyWith(color: lightGrayColor),
            ),
          ],
        ),
        Row(
          children: [
            for (var diet in dietDetailResults)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "${diet.name}  ",
                  style: bodyRegular_14,
                ),
              )
          ],
        ),
      ],
    );
  }
}

class CalendarExerciseEvents extends StatefulWidget {
  final List<Record> todayRecord;
  const CalendarExerciseEvents({Key? key, required this.todayRecord})
      : super(key: key);

  @override
  State<CalendarExerciseEvents> createState() => _CalendarExerciseEventsState();
}

class _CalendarExerciseEventsState extends State<CalendarExerciseEvents> {
  List<String> recordNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (Record record in widget.todayRecord) {
      getManualById(record.manualId);
    }
  }

  Future<void> getManualById(String id) async {
    try {
      RoutineManual result = await getRoutineManual(id);
      setState(() {
        recordNames.add(result.manualTitle);
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        recordNames.add("");
      });
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: borderContainer,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.todayRecord.length,
          itemBuilder: (context, index) {
            log("달력");
            log(widget.todayRecord[index].manualId.toString());
            // String? exName = ref
            //     .read(dictionaryNotifierProvider.notifier)
            //     .getDictionaryNameById(widget.todayRecord[index].manualId.toString());
            return ListTile(
              title: Text(
                (recordNames.isNotEmpty && recordNames.length > index)
                    ? recordNames[index]
                    : "",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                widget.todayRecord[index].playMinute.toString() + "분",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "${widget.todayRecord[index].weight}kg * ${widget.todayRecord[index].targetNumber}회 * ${widget.todayRecord[index].setNumber}세트",
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
    );
  }
}
