import 'package:flutter/material.dart';

const _divider = Divider(
  height: 10,
  color: Colors.indigo,
);

class Communitydetail extends StatefulWidget {
  const Communitydetail({Key? key}) : super(key: key);

  @override
  State<Communitydetail> createState() => _CommunitydetailState();
}

class _CommunitydetailState extends State<Communitydetail> {
  Map<String, dynamic> communityData = {};
  final _Controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      communityData = {
        "id": "전민지",
        "title": "님들 오늘 루틴 어떻게 짤꺼임?",
        "content": "dajfdjfskfk\ndfasfjhdskjfk\nfadfdsfda\ndafudhfkdhf",
        "comments": [
          {"id": "홍길동", "text": "어쩔티비저쩔티비"},
          {"id": "김깍쇠", "text": "흠...?나도모름"},
          {"id": "오렌지", "text": "오렌지 오렌지~"},
        ]
      };
    });
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
              Expanded(child: _CommunityBody(communityData: communityData)),
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
                            communityData["comments"]
                                .add({"id": "김만두", "text": _Controller.text});
                            _Controller.text = "";
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommunityBody extends StatelessWidget {
  _CommunityBody({Key? key, required this.communityData}) : super(key: key);
  Map<String, dynamic> communityData;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: communityData["comments"].length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(communityData["title"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          );
        } else if (index == 1) {
          return Container(
            constraints: BoxConstraints(minHeight: 250),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              communityData["content"],
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              communityData["comments"][index - 2]["id"] +
                  ' : ' +
                  communityData["comments"][index - 2]["text"],
              style: TextStyle(fontSize: 15),
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) => _divider,
    );
  }
}
