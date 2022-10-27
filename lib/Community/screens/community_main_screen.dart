import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/Community/providers/community_provider.dart';
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
                    CommunityMainBodyLayout(
                      boardId: boardType[i].id,
                      boardTitle: boardType[i].title,
                    ),
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
