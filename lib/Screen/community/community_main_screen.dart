import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Provider/community_provider.dart';

import 'community_detail_screen.dart';
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
    List<CommunityBoardsList> CommunityList =
        ref.watch(CommunityListNotifierProvider);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: TabBar(
            tabs: [
              Tab(text: '전체'),
              Tab(text: '인증'),
              Tab(text: '질문'),
              Tab(text: '일상'),
              Tab(text: '인기글'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: ListView.separated(
                itemCount: CommunityList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(CommunityList[index].title),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Communitydetail(
                                  id: CommunityList[index].id)));
                    },
                    trailing: Text(CommunityList[index].nickname),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 10,
                  color: Colors.indigo,
                ),
              ),
            ),
            Container(color: Colors.yellow),
            Container(
              color: Colors.greenAccent,
            ),
            Container(
              color: Colors.amber,
            ),
            Container()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo[300],
          tooltip: "글쓰기",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CommunityWrite()));
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
