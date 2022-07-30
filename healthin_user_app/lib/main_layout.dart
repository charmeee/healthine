import 'package:flutter/material.dart';
import 'community/communitymain.dart';
import 'diet/diet.dart';
import 'qrscan/qrscanpage.dart';
import 'dictionary/dictionary.dart';
import 'home/home2.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  List<String> didexercise = [];
  void addDidexercise(String getdata) {
    setState(() {
      didexercise.add(getdata);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Home2(didexercise: didexercise),
      Diet(),
      QrScanPage(didexercise: didexercise, addDidexercise: addDidexercise),
      Community(),
      Dictionary(),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QrScanPage(
                              didexercise: didexercise,
                              addDidexercise: addDidexercise)));
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
