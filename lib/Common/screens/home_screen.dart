import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Diet/widgets/diet_main_card.dart';
import 'package:healthin/Record/screens/whileExercise.dart';
import 'package:healthin/User/models/user_model.dart';
import 'package:healthin/Diet/screens/diet.dart';
import 'package:healthin/znotUseFiles/report_screen.dart';
import 'package:healthin/Routine/screens/routineList_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        "오늘의 음식",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: DietCard(),
                    ),
                  ],
                ),
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
