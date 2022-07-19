import 'package:flutter/material.dart';

class Communitydetail extends StatefulWidget {
  const Communitydetail({Key? key}) : super(key: key);

  @override
  State<Communitydetail> createState() => _CommunitydetailState();
}

class _CommunitydetailState extends State<Communitydetail> {
  List<Widget> Maincontainer = [mainTitle(), mainContext()];
  List<Widget> commentsList = [
    mainComment(contents: 1),
    mainComment(contents: 2),
    mainComment(contents: 3)
  ];
  int communityindex = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communityindex += commentsList.length;
    Maincontainer.addAll(commentsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView.separated(
          itemCount: communityindex,
          itemBuilder: (context, index) {
            return Maincontainer[index];
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 10,
            color: Colors.indigo,
          ),
        ));
  }
}

class mainTitle extends StatelessWidget {
  const mainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        "님들 오늘 루틴 어떻게 짤꺼임?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}

class mainContext extends StatelessWidget {
  const mainContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        "dajfdjfskfk\ndfasfjhdskjfk\nfadfdsfda\ndafudhfkdhf",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class mainComment extends StatelessWidget {
  mainComment({Key? key, this.contents}) : super(key: key);
  var contents;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Text("답글: ${contents}"));
  }
}

class addComment extends StatefulWidget {
  const addComment({Key? key}) : super(key: key);

  @override
  State<addComment> createState() => _addCommentState();
}

class _addCommentState extends State<addComment> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
