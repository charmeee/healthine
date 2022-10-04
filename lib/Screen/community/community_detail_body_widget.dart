import 'package:flutter/material.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:healthin/Model/user_model.dart';

const _divider = Divider(
  height: 10,
  color: Colors.indigo,
);

class CommunityDetailBody extends StatefulWidget {
  final CommunityBoard board;
  final List<CommunityBoardComment> comments;
  final UserInfo user;
  const CommunityDetailBody(
      {Key? key,
      required this.board,
      required this.comments,
      required this.user})
      : super(key: key);

  @override
  State<CommunityDetailBody> createState() => _CommunityDetailBodyState();
}

class _CommunityDetailBodyState extends State<CommunityDetailBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.comments.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(widget.board.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          );
        } else if (index == 1) {
          return Container(
            constraints: BoxConstraints(minHeight: 250),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.board.content,
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.comments[index - 2].author +
                  ' : ' +
                  widget.comments[index - 2].content,
              style: TextStyle(fontSize: 15),
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) => _divider,
    );
  }
}
