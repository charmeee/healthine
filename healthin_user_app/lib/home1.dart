import 'package:flutter/material.dart';
import 'package:healthin/profile.dart';
import 'package:healthin/inbodychart.dart';

class Home1 extends StatelessWidget {
  Home1({Key? key, required this.didexercise}) : super(key: key);
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
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];
    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            //title: Profile(),
            backgroundColor: Colors.indigo,
            leading: Icon(Icons.abc),
            pinned: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(background: Profile()),
          ),
          SliverPersistentHeader(pinned: true, delegate: TabBarDelegate()),
          SliverFillRemaining(
            hasScrollBody: true,
            child: TabBarView(
              children: [
                Tab1(routinelist: routinelist, didexercise: didexercise),
                Tab1(routinelist: routinelist, didexercise: didexercise)
              ],
            ),
          )
        ], //이걸안하면 상단바 생긴만큼 길이가 추가됨;
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: TabBar(
        tabs: [
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: const Text(
                "홈",
              ),
            ),
          ),
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: const Text(
                "특가",
              ),
            ),
          ),
        ],
        indicatorWeight: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, //가로로 꽉차게
            children: [
              Card(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "인바디기록",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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
