import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'community_detail_screen.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
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
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("title"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Communitydetail()));
                    },
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
          onPressed: () {},
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
