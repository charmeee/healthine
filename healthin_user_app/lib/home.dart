import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:healthin/inbodychart.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.didexercise}) : super(key: key);
  List didexercise;
  @override
  Widget build(BuildContext context) {
    double _percent = 0.7;
    List<String> routinelist = [
      "러닝머신 10분",
      "레그익스텐션 10kg 10회 3세트",
      "레드컬 20kg 10회 3세트 ",
      "핵스쿼트 빈바 10회 3세트",
      "레그프레스 10회 3세트",
      "바이시클 크런치 20회 3세트"
    ];

    return Column(
      children: [
        Container(
            color: Colors.indigo,
            height: 230,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "전민지",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 6,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: QrImage(
                                            padding: EdgeInsets.all(20),
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            data: '전민지',
                                          ),
                                        );
                                      });
                                },
                                child: QrImage(
                                  padding: EdgeInsets.all(5),
                                  data: '전민지',
                                  backgroundColor: Colors.white,
                                  size: 150,
                                ),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(4),
                        lineHeight: 14.0,
                        percent: _percent,
                        trailing: Padding(
                          //sufix content
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            '${_percent * 100}%',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ), //right content
                        ),
                        backgroundColor: Colors.grey[700],
                        progressColor: Colors.yellow,
                      ),
                    ),
                  ]),
            )),
        //윗단
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, //가로로 꽉차게
                  children: [
                    Card(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "인바디기록",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                        InbodyChart(),
                      ],
                    )),
                    //인바디 차트
                    Card(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              "오늘의 루틴",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          for (int i = 0; i < routinelist.length; i++)
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${i + 1}. ${routinelist[i]}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ))
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "오늘 운동 기록",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          if (didexercise.isEmpty) ...[
                            Column(
                              children: [
                                Text("오늘의 운동기록이 없습니다."),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text("운동을 기록해보세요!"),
                                )
                              ],
                            )
                          ] else ...[
                            for (int i = 0; i < didexercise.length; i++) ...[
                              Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    '${i + 1}. ${didexercise[i]}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ))
                            ]
                          ],
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        SizedBox(
          height: 70,
        )
      ],
    );
  }
}

// class routine extends StatelessWidget {
//   routine({Key? key}) : super(key: key);
//   List<String> _list=["a","b","c"];
//   var maifri= _list.map((e) => Container());
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
