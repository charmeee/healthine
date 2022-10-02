import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/user_model.dart';
import 'package:healthin/Screen/dictionary/qr_dicctionary.dart';
import 'package:healthin/Screen/diet/diet.dart';
import 'package:healthin/Screen/report/report_screen.dart';
import 'package:healthin/Screen/routineSetting/routineList_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../Provider/user_provider.dart';
import '../userSetting/userSetting.dart';
import 'calendartab/calender.dart';
import '../calender/new_calander.dart';

import 'hometab/Inbody/InbodyCard.dart';
import 'hometab/hometab.dart';
import 'hometab/profile_header/profile.dart';
import 'hometab/routine/routineCard.dart';
import 'hometab/todayexecise/todayExecisedCard.dart';

List<Map> manuButton = [
  {
    "icon": Icons.qr_code,
    "text": "출입 QR",
    "onTab": "QR",
  },
  {
    "icon": Icons.food_bank,
    "text": "운동 식단",
    "onTab": Diet(),
  },
  {
    "icon": Icons.route,
    "text": "루틴 찾기",
    "onTab": UserSetting(),
  },
  {
    "icon": Icons.person,
    "text": "신체 기록",
    "onTab": UserSetting(),
  },
  {
    "icon": Icons.newspaper,
    "text": "공지/민원",
    "onTab": UserSetting(),
  },
  {
    "icon": Icons.calendar_today,
    "text": "달력",
    "onTab": UserSetting(),
  },
  {
    "icon": Icons.settings,
    "text": "설정",
    "onTab": UserSetting(),
  },
  {
    "icon": Icons.logout,
    "text": "로그아웃",
    "onTab": UserSetting(),
  },
];

List<String> day = [
  "월",
  "화",
  "수",
  "목",
  "금",
  "토",
  "일",
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserInfo user = ref.watch(userProfileNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              user.nickname != null ? '${user.nickname}님' : '',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              '  환영합니다.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ],
        ),
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.menu),
        //       color: Colors.black54,
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //     );
        //   },
        // ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserSetting()),
              );
            },
            icon: Icon(Icons.person, color: Colors.black54),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserSetting()),
              );
            },
            icon: Icon(Icons.notifications, color: Colors.black54),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  // color: Colors.red,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(day.length, (index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 25,
                              child: index == 5
                                  ? Image.asset(
                                      'assets/banner_img/running.png',
                                      fit: BoxFit.fill,
                                    )
                                  : null),
                          Container(
                            height: 15,
                            width: 15,
                            margin: EdgeInsets.all(10),
                            // child: Text(day[index]),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (index == 2 || index == 3)
                                  ? Colors.greenAccent
                                  : null,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(day[index]),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "오늘의 루틴",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("루틴을 추가해 보세요."),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoutineList()),
                            );
                          },
                          icon: Icon(Icons.add),
                          iconSize: 50,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QrDictionary(
                                      equipmentId:
                                          'c63d9b90-59bf-4303-b24c-43ff72323216',
                                    )),
                          );
                        },
                        child: Text("사전"),
                        style: ButtonStyle(),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("루틴 시작하기"),
                        style: ButtonStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    './assets/banner_img/img2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "운동리포트",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("운동을 시작해 보세요"),
                        Container(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),

                // CarouselSlider(
                //     options: CarouselOptions(
                //         viewportFraction: 1,
                //         enlargeCenterPage: true,
                //         scrollDirection: Axis.horizontal,
                //         onPageChanged: (index, reason) {
                //           setState(() {
                //             _current = index;
                //           });
                //         }),
                //     items: [1, 2, 3, 4].map((i) {
                //       return Builder(
                //         builder: (BuildContext context) {
                //           return SizedBox(
                //             height: 30,
                //             child: Image.asset(
                //               './assets/banner_img/img$i.png',
                //               fit: BoxFit.cover,
                //               height: 20,
                //             ),
                //           );
                //         },
                //       );
                //     }).toList()),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [1, 2, 3, 4].map((i) {
                //       int index = [1, 2, 3, 4].indexOf(i);
                //       return Container(
                //         width: 10,
                //         height: 10,
                //         margin:
                //             EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: _current == index
                //               ? Colors.indigo
                //               : Colors.grey[400],
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),
              ],
            ),
            GridView.count(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              children: manuButton.map((item) {
                return Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: 100,
                  child: InkWell(
                      onTap: () {
                        if (item["onTab"] == "QR") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: QrImage(
                                    padding: EdgeInsets.all(20),
                                    size:
                                        MediaQuery.of(context).size.width * 0.8,
                                    data: '전민지',
                                  ),
                                );
                              });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => item["onTab"]),
                          );
                        }
                      },
                      child: iconContainer(item["icon"], item["text"])),
                );
              }).toList(),
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "이번주에 운동을 하지 않았어요..",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    Text(
                      "운동을 시작해보세요!",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RoutineCard(), //오늘의 루틴
                InbodyCard(), //인바디 차트
                ExecisedCard(),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(4),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black54),
                      child: const Text(
                        "리포트 보기",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Report()));
                      }),
                )
              ],
            )
          ],
        ),
      ),
      // drawer: HomeDrawer(),
    );
  }

  Widget iconContainer(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.black87,
          size: 25,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }
}
