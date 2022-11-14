import 'package:flutter/material.dart';
import 'package:healthin/Common/Const/const.dart';
import '../../Calender/screens/new_calander.dart';
import '../screens/home_screen.dart';
import '../../Community/screens/community_main_screen.dart';
import '../../Diet/screens/diet.dart';
import '../../Dictionary/screens/qrscan_screen.dart';
import '../../Dictionary/screens/main_dictionary_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  //ㅇㅣ름,횟수,시간
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
      const CalendarTab(),
      QrScanPage(),
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
                    if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrScanPage()));
                    } else {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }
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
                        Icons.camera_alt,
                      ),
                      label: "기구 스캔",
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
