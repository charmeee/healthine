import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/community_provider.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:healthin/Service/community_api.dart';

import 'community_detail_screen.dart';

class CommunityMainBodyLayout extends StatefulWidget {
  final String boardId;

  const CommunityMainBodyLayout({Key? key, required this.boardId})
      : super(key: key);

  @override
  State<CommunityMainBodyLayout> createState() =>
      _CommunityMainBodyLayoutState();
}

class _CommunityMainBodyLayoutState extends State<CommunityMainBodyLayout> {
  int nowPage = 1;
  int limit = 20;
  List<CommunityBoard> boards = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBoardList(nowPage);
  }

  getBoardList(int page) async {
    List<CommunityBoard> tmp =
        await getCommunityBoardList(page, limit, widget.boardId);
    setState(() {
      boards = [...tmp];
    });
  }

  @override
  Widget build(BuildContext context) {
    return boards.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemCount: boards.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(boards[index].title),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommunityDetail(
                              boardId: widget.boardId,
                              postId: boards[index].id)));
                },
                trailing: Text(boards[index].author),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 10,
              color: Colors.indigo,
            ),
          );
  }
}
