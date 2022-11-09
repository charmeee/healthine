import 'package:flutter/material.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/User/models/user_model.dart';

const _divider = Divider(
  height: 10,
  color: Colors.indigo,
);

class CommunityDetailBody extends StatefulWidget {
  final CommunityBoard board;
  final List<CommunityBoardComment> comments;
  final UserInfo user;
  final Function addLike;
  final Function(String? id, String? name) setReply;
  final String? replyId;
  final String? replyName;
  const CommunityDetailBody(
      {Key? key,
      required this.board,
      required this.comments,
      required this.user,
      required this.addLike,
      required this.setReply,
      this.replyId,
      this.replyName})
      : super(key: key);

  @override
  State<CommunityDetailBody> createState() => _CommunityDetailBodyState();
}

class _CommunityDetailBodyState extends State<CommunityDetailBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.comments.length + 3,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(widget.board.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white)),
              ),
              SizedBox(
                height: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.board.author,
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 4),
                      child: const VerticalDivider(
                        color: Colors.indigo,
                        width: 10,
                      ),
                    ),
                    Text(
                      widget.board.createdAt.toString(),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          );
        } else if (index == 1) {
          return Container(
            constraints: BoxConstraints(minHeight: 250),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.board.content ?? "",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        } else if (index == 2) {
          return Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                widget.addLike();
              },
              child: Text(
                '좋아요 ${widget.board.likesCount}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          return GestureDetector(
              onTap: () {
                //부모댓글이면
                if (widget.replyId == widget.comments[index - 3].id) {
                  //댓글달기창이 열려있으면
                  widget.setReply(null, null);
                } else {
                  widget.setReply(widget.comments[index - 3].id,
                      widget.comments[index - 3].author);
                }
              },
              child: widget.comments[index - 3].childComments == null ||
                      widget.comments[index - 3].childComments!.isEmpty
                  ? Padding(
                      //부모댓글이면
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.comments[index - 3].author +
                            ' : ' +
                            widget.comments[index - 3].content,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          //부모댓글이면
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.comments[index - 3].author +
                                ' : ' +
                                widget.comments[index - 3].content,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        _divider,
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.comments[index - 3].childComments!
                              .length, //자식댓글 갯수
                          itemBuilder: (context, childIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "   ㄴ" +
                                    widget.comments[index - 3]
                                        .childComments![childIndex].author +
                                    ' : ' +
                                    widget.comments[index - 3]
                                        .childComments![childIndex].content,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return _divider;
                          },
                        ),
                      ],
                    ));
        }
      },
      separatorBuilder: (BuildContext context, int index) => _divider,
    );
  }
}
