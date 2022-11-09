import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../screens/community_detail_screen.dart';

class MainCommunityListTile extends StatelessWidget {
  final CommunityBoard board;
  final String boardId;
  final GlobalKey<RefreshIndicatorState> refreshKey;
  const MainCommunityListTile(
      {Key? key,
      required this.board,
      required this.boardId,
      required this.refreshKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = board.createdAt != null
        ? DateFormat('yyyy-MM-dd hh:mm').format(board.createdAt!)
        : '';
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommunityDetail(
                        boardId: boardId,
                        postId: board.id,
                        boardTitle: board.title,
                      ))).then((value) => refreshKey.currentState?.show());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                board.title,
                maxLines: 1,
                style: bodyRegular_16,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    board.author,
                    style: bodyRegular_14,
                  ),
                  Text(" · " + formattedDate,
                      style: bodyRegular_12.copyWith(color: mediumGrayColor)),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Text(board.author),
                      SvgPicture.asset(
                        'assets/icons/comment.svg',
                        color: mediumGrayColor,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        board.commentsCount.toString(),
                        style: bodyRegular_14.copyWith(color: mediumGrayColor),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        'assets/icons/view.svg',
                        color: mediumGrayColor,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        board.views.toString(),
                        style: bodyRegular_14.copyWith(color: mediumGrayColor),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if (board.hasImages != null && board.hasImages!)
                        SvgPicture.asset(
                          'assets/icons/img.svg',
                          color: mediumGrayColor,
                          width: 20,
                          height: 20,
                        ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/thumbup.svg',
                        color: mediumGrayColor,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        board.likesCount.toString(),
                        style: bodyRegular_14.copyWith(color: mediumGrayColor),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
