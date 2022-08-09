import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';
import 'package:healthin/Service/auth_request_api.dart';
import 'home/home_screen.dart';
import 'community/community_main_screen.dart';
import 'diet/diet.dart';
import 'qrscan/qrscanpage.dart';
import 'dictionary/dictionary.dart';

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
    final List<Widget> _widgetOptions = <Widget>[
      Home2(),
      Diet(),
      QrScanPage(),
      Community(),
      Dictionary(addmode: false),
    ];
    return SafeArea(
      child: Scaffold(
        //extendBody: true,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              backgroundColor: Colors.indigo,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                if (index == 2) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QrScanPage()));
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              unselectedItemColor: Colors.grey[400],
              selectedItemColor: Colors.white,
              // unselectedIconTheme: IconThemeData(color: Colors.grey[100]),
              // selectedIconTheme: IconThemeData(color: Colors.white),
              // unselectedLabelStyle: TextStyle(color: Colors.grey[100]),
              // selectedLabelStyle: TextStyle(color: Colors.white),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.food_bank,
                  ),
                  label: "식단",
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
            )),
      ),
    );
  }
}