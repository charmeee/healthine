import 'package:flutter/material.dart';
import 'package:healthin/Const/const.dart';

import 'widgets/routineListTab_layout.dart';

class RoutineList extends StatefulWidget {
  const RoutineList({Key? key}) : super(key: key);

  @override
  State<RoutineList> createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("루틴 목록"),
          bottom: TabBar(
            tabs: [
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  'Tab1',
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  'Tab2',
                ),
              ),
            ],
            indicator: BoxDecoration(
              color: Colors.greenAccent,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          children: [
            RoutineListTabLayout(),
            RoutineListTabLayout(),
          ],
          controller: _tabController,
        ));
  }
}
