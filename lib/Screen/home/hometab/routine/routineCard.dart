import 'package:flutter/material.dart';

import 'routineSetting.dart';

class routineCard extends StatefulWidget {
  const routineCard({Key? key}) : super(key: key);

  @override
  State<routineCard> createState() => _routineCardState();
}

class _routineCardState extends State<routineCard> {
  int _index = 0;
  // List<String> routinelist = [
  //   "러닝머신 10분",
  //   "레그익스텐션 10kg 10회 3세트",
  //   "레드컬 20kg 10회 3세트 ",
  //   "핵스쿼트 빈바 10회 3세트",
  //   "레그프레스 10회 3세트",
  //   "바이시클 크런치 20회 3세트"
  // ];
  List routineList = [
    {"type": "러닝머신", "count": "10분", "img": "assets/running mashin.png"},
    {
      "type": "레그 익스텐션",
      "count": "10kg 10회 3세트",
      "img": "assets/Leg extension.png"
    },
    {"type": "레그 컬", "count": "20kg 10회 3세트", "img": "assets/leg curl.png"},
    {
      "type": "스컬 크러셔",
      "count": "10kg 10회 3세트",
      "img": "assets/Skull Crusher.png"
    },
    {"type": "펙덱", "count": "10kg 15회 3세트", "img": "assets/Pec Deck .png"},
  ];

  void changeRoutine(List Routine) {
    setState(() {
      routineList = [...Routine];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: const Text(
              "오늘의 루틴",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 250,
            child: PageView.builder(
              itemCount: 5,
              controller: PageController(viewportFraction: 0.7),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (BuildContext context, int index) {
                return Transform.scale(
                  scale: index == _index ? 1 : 0.9,
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          routineList[index]["img"],
                          height: 170,
                        ),
                        Text(
                          routineList[index]["type"],
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          routineList[index]["count"],
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoutineSetting(
                            routineList: routineList,
                            changeRoutine: changeRoutine)));
              },
              child: Text("루틴 수정하기"),
              style: ElevatedButton.styleFrom(primary: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
}
