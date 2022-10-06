import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:healthin/Provider/community_provider.dart';
import 'package:healthin/Service/community_api.dart';

// import 'community_detail_screen.dart';
import 'community_main_body_widget.dart';
import 'communiuty_write_screen.dart';

enum CommunityListFilter {
  all,
  active,
  completed,
} //나중에 카테고리 별 분류할 예정

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
    await ref.read(communityProvider.notifier).initCommunityBoards(tmp);
  }

  @override
  Widget build(BuildContext context) {
    return (boardType.length > 0)
        ? DefaultTabController(
            length: boardType.length,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigo,
                title: TabBar(
                  tabs: [
                    ...boardType.map(
                      (e) => Tab(text: e.title.toString()),
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  for (int i = 0; i < boardType.length; i++)
                    CommunityMainBodyLayout(boardId: boardType[i].id),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.indigo[300],
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
            ))
        : Center(child: CircularProgressIndicator());
  }
}
