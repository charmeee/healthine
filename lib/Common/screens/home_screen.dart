import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/buttonStyle.dart';
import 'package:healthin/Diet/widgets/diet_main_card.dart';
import 'package:healthin/Record/screens/whileExercise.dart';
import 'package:healthin/User/models/user_model.dart';
import 'package:healthin/Diet/screens/diet.dart';
import 'package:healthin/znotUseFiles/report_screen.dart';
import 'package:healthin/Routine/screens/routineList_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../Diet/models/diet_model.dart';
import '../../Diet/providers/diet_provider.dart';
import '../../Record/models/exerciserecord_model.dart';
import '../../Record/providers/exercisedata_provider.dart';
import '../../Routine/models/routine_models.dart';
import '../../Routine/providers/routine_provider.dart';
import '../../User/providers/user_provider.dart';
import '../../User/screens/userSetting_screen.dart';

import '../../Routine/widgets/routineCard.dart';
import '../../Record/widgets/todayExecisedCard.dart';
import '../../Diet/screens/diet_input_screen.dart';
import '../styles/boxStyle.dart';
import '../styles/textStyle.dart';

const double profileImageSize = 44;
const double primaryButtonHeight = 56;

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
    "onTab": DietInputScreen(),
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
    final todayRoutine = ref.watch(todayRoutineProvider);
    final todayRecord = ref.watch(todayRecordProvider);
    int todayTotalExerciseTime = 0;
    for (Record record in todayRecord) {
      todayTotalExerciseTime += record.playMinute;
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 12,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserSetting()),
                            );
                          },
                          child: ClipOval(
                            clipper: MyOvalClipper(),
                            child: SvgPicture.asset(
                              'assets/icons/profile.svg',
                              height: profileImageSize,
                              width: profileImageSize,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF262A2F), width: 1),
                            color: backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 21,
                            icon: SvgPicture.asset(
                              'assets/icons/bell.svg',
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${user.nickname ?? ""}님\n오늘도 헬신과 함께",
                      style: h2Regular_22,
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  height: 432,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "오늘의 루틴",
                        style: h3Bold_18,
                      ),
                      Container(
                          height: 392,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          decoration: borderContainer,
                          child: todayRoutine.when(
                            data: (data) {
                              return RoutineCard(
                                myRoutines: data,
                                records: todayRecord,
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stack) => const Center(
                              child: Text('Error'),
                            ),
                          ))
                      //borderContainer.
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "일일 활동",
                  style: h3Bold_18,
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.36,
                      width: MediaQuery.of(context).size.width * 0.43,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      decoration: filledContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 36,
                            width: 36,
                            margin: EdgeInsets.only(bottom: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              'assets/icons/exercise.svg',
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            (todayTotalExerciseTime / 60).toInt().toString() +
                                "h " +
                                (todayTotalExerciseTime % 60).toString() +
                                "min",
                            style: bodyBold_16,
                          ),
                          Text(
                            "운동시간",
                            style: bodyRegular_14,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.36,
                      width: MediaQuery.of(context).size.width * 0.43,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      decoration: filledContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 36,
                            width: 36,
                            margin: EdgeInsets.only(bottom: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              'assets/icons/exercise.svg',
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            (todayRecord.length).toString() + "개",
                            style: bodyBold_16,
                          ),
                          Text(
                            "운동개수",
                            style: bodyRegular_14,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                ),
                //식단부분 위젯 분리시켜야함
                DietCard(),
                Container(
                  height: primaryButtonHeight,
                  margin: EdgeInsets.symmetric(vertical: 24),
                  child: ElevatedButton(
                      style: primaryButton,
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
            ),
          ),
        ),
        // drawer: HomeDrawer(),
      ),
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

class MyOvalClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    //modify value here based on your need
    //size width = 30.0, and height = 30.0 regardless of child size its don't matter
    var rect =
        const Rect.fromLTWH(0.0, 0.0, profileImageSize, profileImageSize);
    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

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
