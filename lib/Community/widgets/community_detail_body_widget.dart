import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/User/models/user_model.dart';

const _divider = Divider(
  height: 10,
  color: darkGrayColor,
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
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.comments.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  widget.board.title,
                  style: h1Regular_24.copyWith(fontSize: 22),
                ),
              ),
              SizedBox(
                height: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.board.author,
                      style: bodyRegular_14,
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 50),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.board.content ?? "",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              if (widget.board.images != null &&
                  widget.board.images!.isNotEmpty)
                Image.network(
                  imgBaseUrl + widget.board.images![0],
                ),
              SizedBox(
                height: 64,
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      widget.addLike();
                    },
                    icon: SvgPicture.asset("assets/icons/thumbup.svg"),
                    label: Text(
                      '좋아요  ${widget.board.likesCount}',
                      style: bodyRegular_14,
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      widget.addLike();
                    },
                    icon: SvgPicture.asset("assets/icons/comment.svg"),
                    label: Text(
                      '댓글  ${widget.board.commentsCount}',
                      style: bodyRegular_14,
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              )
            ],
          );
        } else {
          return GestureDetector(
              onTap: () {
                //부모댓글이면
                if (widget.replyId == widget.comments[index - 2].id) {
                  //댓글달기창이 열려있으면
                  widget.setReply(null, null);
                } else {
                  widget.setReply(widget.comments[index - 2].id,
                      widget.comments[index - 2].author);
                }
              },
              child: widget.comments[index - 2].childComments == null ||
                      widget.comments[index - 2].childComments!.isEmpty
                  ? Padding(
                      //부모댓글이면
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.comments[index - 2].author +
                            ' : ' +
                            widget.comments[index - 2].content,
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
                            widget.comments[index - 2].author +
                                ' : ' +
                                widget.comments[index - 2].content,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        _divider,
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.comments[index - 2].childComments!
                              .length, //자식댓글 갯수
                          itemBuilder: (context, childIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "   ㄴ" +
                                    widget.comments[index - 2]
                                        .childComments![childIndex].author +
                                    ' : ' +
                                    widget.comments[index - 2]
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
