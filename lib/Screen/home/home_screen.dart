import 'package:flutter/material.dart';
import '../userSetting/userSetting.dart';
import 'calendartab/calender.dart';
import 'home_drawer.dart';
import 'hometab/hometab.dart';
import 'hometab/profile_header/profile.dart';

class Home2 extends StatelessWidget {
  Home2({Key? key}) : super(key: key);
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
                pinned: true,
                floating: true,
                //snap: true,
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
            //physics: NeverScrollableScrollPhysics(),
            //physics: PageScrollPhysics(),
            children: [
              Tab1(),
              Tab2(),
            ],
          ),
        ),
      ),
      drawer: HomeDrawer(),
    );
  }
}
