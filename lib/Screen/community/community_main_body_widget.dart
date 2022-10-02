import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/community_provider.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class MainbodyLayout extends ConsumerWidget {
  const MainbodyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communityBoardsList = ref.watch(communityBoardsListProvider);
    return communityBoardsList.boards.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemCount: communityBoardsList.boards.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(communityBoardsList.boards[index].title),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Communitydetail(
                  //             id: CommunityList[index].id)));
                },
                trailing: Text(communityBoardsList.boards[index].author),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 10,
              color: Colors.indigo,
            ),
          );
  }
}
