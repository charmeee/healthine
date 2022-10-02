import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:healthin/Provider/community_provider.dart';

// import 'community_detail_screen.dart';
import 'communiuty_write_screen.dart';

enum CommunityListFilter {
  all,
  active,
  completed,
} //나중에 카테고리 별 분류할 예정

class Community extends ConsumerWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref를 사용해 프로바이더 구독(listen)하기
    // List<CommunityBoardsType> CommunityList =
    //     ref.watch(CommunityListNotifierProvider);
    List<CommunityBoardsType> boardType =
        ref.watch(communityBoardsTypeProvider);
    log("currentBoardIdProvider" +
        ref.watch(currentBoardIdProvider).toString());
    return (boardType.length > 0)
        ? DefaultTabController(
            length: boardType.length,
            child: Builder(builder: (context) {
              final tabController = DefaultTabController.of(context)!;
              tabController.addListener(() {
                if (!tabController.indexIsChanging) {
                  ref.read(currentBoardIdProvider.notifier).state =
                      boardType[tabController.index].id;
                }
              });

              return Scaffold(
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
                      Container(
                        color: Colors.orange,
                      ),
                    // Container(
                    //     // child: ListView.separated(
                    //     //   itemCount: CommunityList.length,
                    //     //   itemBuilder: (context, index) {
                    //     //     return ListTile(
                    //     //       title: Text(CommunityList[index].title),
                    //     //       onTap: () {
                    //     //         Navigator.push(
                    //     //             context,
                    //     //             MaterialPageRoute(
                    //     //                 builder: (context) => Communitydetail(
                    //     //                     id: CommunityList[index].id)));
                    //     //       },
                    //     //       trailing: Text(CommunityList[index].slug),
                    //     //     );
                    //     //   },
                    //     //   separatorBuilder: (BuildContext context, int index) => Divider(
                    //     //     height: 10,
                    //     //     color: Colors.indigo,
                    //     //   ),
                    //     // ),
                    //     ),
                    // Container(color: Colors.yellow),
                    // Container(
                    //   color: Colors.greenAccent,
                    // ),
                    // Container(
                    //   color: Colors.amber,
                    // ),
                    // Container()
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.indigo[300],
                  tooltip: "글쓰기",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommunityWrite()));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          )
        : Center(child: CircularProgressIndicator());
  }
}
