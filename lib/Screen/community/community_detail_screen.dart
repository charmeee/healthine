import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/models.dart';
import 'package:healthin/Provider/user_provider.dart';

import '../../Provider/community_provider.dart';

const _divider = Divider(
  height: 10,
  color: Colors.indigo,
);

class Communitydetail extends ConsumerStatefulWidget {
  const Communitydetail({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  ConsumerState<Communitydetail> createState() => _CommunitydetailState();
}

class _CommunitydetailState extends ConsumerState<Communitydetail> {
  Map<String, dynamic> communityData = {};
  final _Controller = TextEditingController();
  late var user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(CommunityDataNotifierProvider.notifier).getComunnity(widget.id);
    user = ref.read(userStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _CommunityBody()),
                Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _Controller,
                          decoration: InputDecoration(labelText: "댓글을 입력해주세요"),
                        )),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            setState(() {
                              communityData["comments"].add({
                                "id": user.nickname.toString(),
                                "text": _Controller.text
                              });
                              _Controller.text = "";
                            });
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        )
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}

class _CommunityBody extends ConsumerWidget {
  _CommunityBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CommunityBoardData? boardData = ref.watch(CommunityDataNotifierProvider);
    if (boardData != null) {
      int length =
          (boardData.comment != null) ? boardData.comment!.length + 2 : 2;
      log(length.toString());
      return ListView.separated(
        itemCount: length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(boardData.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            );
          } else if (index == 1) {
            return Container(
              constraints: BoxConstraints(minHeight: 250),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                boardData.content,
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                boardData.comment![index - 2]["id"] +
                    ' : ' +
                    boardData.comment![index - 2]["text"],
                style: TextStyle(fontSize: 15),
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) => _divider,
      );
    } else {
      return Center(
        child: Text("로딩중"),
      );
    }
  }
}
