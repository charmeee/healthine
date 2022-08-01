import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Diet extends StatefulWidget {
  const Diet({Key? key}) : super(key: key);

  @override
  State<Diet> createState() => _DietState();
}

class _DietState extends State<Diet> {
  final int recommended_calories = 2000;
  int ate_calories = 0;
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Map<String, List<dynamic>> result = {
    "아침": ["밥", "김치", "김"],
    "점심": [],
    "저녁": [],
    "간식": [],
  };
  Map<String, int> caloriesByTime = {
    "아침": 0,
    "점심": 203,
    "저녁": 700,
    "간식": 300,
  };

  DateTime nowDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  initState() {
    ate_calories =
        caloriesByTime.values.reduce((value, element) => value + element);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DateHeader(
                  onDatePicker: onDatePicker,
                  selectedDate: selectedDate,
                  nowDate: nowDate),
              //버튼누르면 정보가 없을시 -> 먹은거 보여주고 추가 버튼
              //정보가없을 시 -> 입력버튼.
              _DateButtons(
                result: result,
              ),
              //ate_calories,recommended_calories,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TodayCaloriesCard(
                        ate_calories: ate_calories,
                        recommended_calories: recommended_calories,
                        caloriesByTime: caloriesByTime),
                    _NutritionalAnalysisCard()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onDatePicker() {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(nowDate.year + 1))
        .then((date) => setState(() {
              selectedDate = date!;
            }));
  }
}

class _DateHeader extends StatelessWidget {
  _DateHeader(
      {Key? key,
      required this.onDatePicker,
      required this.selectedDate,
      required this.nowDate})
      : super(key: key);
  final VoidCallback onDatePicker;
  DateTime selectedDate;
  DateTime nowDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onDatePicker,
        child: Text(
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}

class _DateButtons extends StatelessWidget {
  _DateButtons({Key? key, required this.result}) : super(key: key);
  final Map<String, List<dynamic>> result;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: result.keys
              .map((e) => TextButton(
                    onPressed: () {
                      onTimePressed(e, context);
                    },
                    child: Text(
                      e,
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo[100],
                      minimumSize: Size(90, 70),
                    ),
                  ))
              .toList()),
    );
  }

  onTimePressed(time, context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints(minHeight: 150),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: result[time]!.length < 4
                  ? 160
                  : 40 + result[time]!.length * 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (result[time]!.isEmpty) ...{
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text("기록된 식단이 없습니다.입력해주세요."),
                        ),
                      ),
                    )
                  } else ...{
                    for (String value in result[time]!) ...{
                      SizedBox(height: 30, child: Center(child: Text(value)))
                    }
                  },
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "입력하기",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.indigo[200]),
                    ),
                  )
                ],
              ),
            ),
          );
        });
    print(result[time]?.length);
  }
}

class _TodayCaloriesCard extends StatelessWidget {
  _TodayCaloriesCard(
      {Key? key,
      required this.ate_calories,
      required this.recommended_calories,
      required this.caloriesByTime})
      : super(key: key);
  final int ate_calories;
  final int recommended_calories;
  final Map<String, int> caloriesByTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(children: [
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 20.0,
            percent: ate_calories / recommended_calories,
            header: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text(
                "오늘 섭취 칼로리",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            center: Icon(
              Icons.fastfood_sharp,
              size: 50.0,
              color: Colors.green[300],
            ),
            backgroundColor: Colors.grey,
            progressColor: Colors.green[300],
            footer: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text("$ate_calories kcal",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Column(
              children: caloriesByTime.keys
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "$e : ${caloriesByTime[e]}",
                          style: TextStyle(fontSize: 17),
                        ),
                      ))
                  .toList()),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}

class _NutritionalAnalysisCard extends StatelessWidget {
  const _NutritionalAnalysisCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: 250,
                  lineHeight: 10,
                  leading: Text("탄수화물"),
                  percent: 0.3,
                  trailing: Text("00%"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: 250,
                  lineHeight: 10,
                  leading: Text("단백질   "),
                  percent: 0.7,
                  trailing: Text("00%"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: 250,
                  lineHeight: 10,
                  leading: Text("지방      "),
                  percent: 0.2,
                  trailing: Text("00%"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
