import 'package:flutter/material.dart';
import 'package:healthin/community.dart';
import 'package:healthin/diet.dart';
import 'package:healthin/qrscanpage.dart';
import 'package:healthin/dictionary.dart';
import 'package:healthin/home2.dart';
import 'package:healthin/home1.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'bonoteam',
    theme: ThemeData(),
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  List<String> didexercise = [];
  void addDidexercise(String getdata) {
    setState(() {
      didexercise.add(getdata);
    });
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
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.indigo[100],
      //   title: Text("fddfsa"),
      // ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "운동기구 스캔",
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QrScanPage(
                      didexercise: didexercise,
                      addDidexercise: addDidexercise)));
        },
        child: Icon(
          Icons.camera_alt,
          color: Colors.indigo[700],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor: Colors.indigo[500],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
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
    );
  }
}
