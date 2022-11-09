import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/Community/services/community_api.dart';

import '../widgets/community_main_body_widget.dart';
import 'communiuty_write_screen.dart';

class Community extends ConsumerStatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  ConsumerState<Community> createState() => _CommunityState();
}

class _CommunityState extends ConsumerState<Community> {
  List<CommunityBoardsType> boardType = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    List<CommunityBoardsType> tmp = await getCommunityBoardsType();
    setState(() {
      boardType = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (boardType.isNotEmpty)
        ? DefaultTabController(
            length: boardType.length,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: backgroundColor,
                  title: Container(
                      padding: EdgeInsets.only(top: 24),
                      height: 64,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '커뮤니티',
                        style: h1Bold_24,
                      )),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60.0),
                    child: Row(
                      children: [
                        IntrinsicWidth(
                          child: TabBar(
                            indicatorColor: whiteColor,
                            tabs: [
                              ...boardType.map(
                                (e) => Tab(text: e.title.toString()),
                              )
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    for (int i = 0; i < boardType.length; i++)
                      CommunityMainBodyLayout(
                        boardId: boardType[i].id,
                        boardTitle: boardType[i].title,
                      ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: primaryColor,
                  tooltip: "글쓰기",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CommunityWrite(boardType: boardType)));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ))
        : Center(child: CircularProgressIndicator());
  }
}
