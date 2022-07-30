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
  final int ate_calories = 700;
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Map<String, List<dynamic>> result = {
    "아침": ["밥", "김치", "김"],
    "점심": [],
    "저녁": [],
    "간식": [],
  };

  @override
  Widget build(BuildContext context) {
    DateTime NowDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: TextButton(
                child: Text(
                  '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black),
                ),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(NowDate.year + 1))
                      .then((date) => setState(() {
                            selectedDate = date!;
                          }));
                },
              ),
            ),
            //버튼누르면 정보가 없을시 -> 먹은거 보여주고 추가 버튼
            //정보가없을 시 -> 입력버튼.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //expand랑 패딩을 섞으면 더좋지않을까.
                  TextButton(
                    onPressed: () {
                      onTimePressed(context, "아침");
                    },
                    child: Text(
                      "아침",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo[100],
                      minimumSize: Size(90, 70),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onTimePressed(context, "점심");
                    },
                    child: Text(
                      "점심",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo[100],
                      minimumSize: Size(90, 70),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onTimePressed(context, "저녁");
                    },
                    child: Text(
                      "저녁",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo[100],
                      minimumSize: Size(90, 70),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onTimePressed(context, "간식");
                    },
                    child: Text(
                      "간식",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo[100],
                      minimumSize: Size(90, 70),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
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
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text("$ate_calories kcal",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "아침 : 290kcal",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "점심 : 290kcal",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "저녁 : 290kcal",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ]),
                    ),
                  ),
                  Padding(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTimePressed(context, String time) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: BoxConstraints(minHeight: 150),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: result[time]!.length < 4
                  ? 160
                  : 40 + result[time]!.length * 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (String value in result[time]!) ...{
                    SizedBox(height: 30, child: Center(child: Text(value)))
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

class DietDialog extends StatelessWidget {
  const DietDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
