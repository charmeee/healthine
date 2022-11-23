import 'package:flutter/material.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Report/models/report_model.dart';
import 'package:healthin/Report/screens/report_error_screen.dart';
import 'package:healthin/Report/screens/report_screen.dart';
import 'package:healthin/Report/services/report_api.dart';
import '../../Calender/screens/new_calander.dart';
import '../screens/home_screen.dart';
import '../../Community/screens/community_main_screen.dart';

import '../../Dictionary/screens/main_dictionary_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  Report report = Report.init();

  //ㅇㅣ름,횟수,시간
  @override
  void initState() {
    super.initState();
    getReport();
  }

  getReport() async {
    Report tmp = await createNewReport();
    setState(() {
      report = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
      const CalendarTab(),
      report.id != null ? ReportScreen(id: report.id!) : const ReportError(),
      const Community(),
      const Dictionary(addmode: false),
    ];
    return SafeArea(
      child: Scaffold(
        //extendBody: true,
        body: widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 1,
                  color: darkGrayColor,
                ),
                BottomNavigationBar(
                  backgroundColor: backgroundColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  onTap: (int index) {
                    // if (index == 2) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => QrScanPage()));
                    // } else {
                    //   setState(() {
                    //     _selectedIndex = index;
                    //   });
                    // }
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  unselectedItemColor: Colors.grey[400],
                  selectedItemColor: Colors.white,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_filled,
                      ),
                      label: "홈",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                      label: "운동 달력",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.sticky_note_2,
                      ),
                      label: "리포트",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.comment,
                      ),
                      label: "커뮤니티",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.library_books,
                      ),
                      label: "운동사전",
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
