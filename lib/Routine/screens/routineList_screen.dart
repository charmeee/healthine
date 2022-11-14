import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Routine/screens/routineSetting_screen.dart';
import '../widgets/myRoutineListTab_layout.dart';
import '../widgets/referenceRoutineListTab_layout.dart';
import '../widgets/routineName_dialog.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class RoutineList extends StatefulWidget {
  const RoutineList({Key? key}) : super(key: key);

  @override
  State<RoutineList> createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _routineFormKey = GlobalKey<FormState>();
  List<bool> isTab = [true, false];
  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  changeTabs(int index) {
    setState(() {
      isTab = [false, false];
      isTab[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: Text("루틴 목록"),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete))
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(84.0),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: darkGrayColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 0, 16),
                    child: Row(
                      children: [
                        IntrinsicWidth(
                          child: TabBar(
                            indicator: BubbleTabIndicator(
                                indicatorColor: primaryColor,
                                indicatorHeight: 26,
                                // Other flags
                                // indicatorRadius: 1,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8)),
                            indicatorColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Text(
                                  "내 루틴",
                                ),
                              ),
                              // ),
                              Tab(
                                child: Text(
                                  "참고 루틴",
                                ),
                              ),
                            ],
                            labelStyle: bodyBold_16,
                            unselectedLabelStyle:
                                bodyRegular_16.copyWith(color: darkGrayColor),
                            controller: _tabController,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Form(
                      key: _routineFormKey,
                      child: NameInputDialog(
                        routineFormKey: _routineFormKey,
                        hasReference: false,
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
            backgroundColor: primaryColor,
          ),
          body: TabBarView(
            children: [
              MyRoutineListTabLayout(),
              ReferenceRoutineListTabLayout(),
            ],
            controller: _tabController,
          )),
    );
  }
}
