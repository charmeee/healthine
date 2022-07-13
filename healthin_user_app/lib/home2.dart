import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:healthin/profile.dart';
import 'package:healthin/inbodychart.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class Home2 extends StatelessWidget {
  Home2({Key? key, required this.didexercise}) : super(key: key);
  List didexercise;
  List<String> routinelist = [
    "러닝머신 10분",
    "레그익스텐션 10kg 10회 3세트",
    "레드컬 20kg 10회 3세트 ",
    "핵스쿼트 빈바 10회 3세트",
    "레그프레스 10회 3세트",
    "바이시클 크런치 20회 3세트"
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['홈', '달력'];
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          physics: PageScrollPhysics(),
          //physics: NeverScrollableScrollPhysics(), //이걸안하면 상단바 생긴만큼 길이가 추가됨;but 하면아래로 스크롤이 안됨.
          // NeverScrollableScrollPhysics : 목록 스크롤 불가능하게 설정
          // BouncingScrollPhysics : 튕겨저 올라가는 듯한 동작 가능 List 끝에 도달했을 시에 다시 되돌아감
          // ClampingScrollPhysics : 안드로이드의 기본 스크롤과 동일하다. List의 끝에 도달하면 동작을 멈춤
          // PageScrollPhysics : 다른 스크롤에 비해 조금더 부드럽게 만듬
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.indigo,
                // leading: IconButton(
                //   icon: Icon(Icons.menu),
                //   onPressed: () => _key.currentState!.openEndDrawer(),
                // ),
                pinned: true,
                floating: true,
                expandedHeight: 270.0,
                flexibleSpace: FlexibleSpaceBar(background: Profile()),
                bottom: TabBar(
                  // These are the widgets to put in each tab in the tab bar.
                  tabs: tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            ];
          },

          body: TabBarView(
            //physics: BouncingScrollPhysics(),
            children: [
              Tab1(routinelist: routinelist, didexercise: didexercise),
              Tab1(routinelist: routinelist, didexercise: didexercise),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              accountName: Text("yong"),
              accountEmail: Text("otrodevym@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                //backgroundImage: null,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[850],
              ),
              title: Text('Home'),
              onTap: () {
                print('Home is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('Setting'),
              onTap: () {
                print('Setting is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.grey[850],
              ),
              title: Text('Q&A'),
              onTap: () {
                print('Q&A is clicked');
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  Tab1({Key? key, required this.routinelist, required this.didexercise})
      : super(key: key);
  final List<String> routinelist;
  final List didexercise;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, //가로로 꽉차게
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
                //오늘의 루틴
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
                SizedBox(
                  height: 70,
                )
              ]),
        ),
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      height: 50,
    );
  }
}
