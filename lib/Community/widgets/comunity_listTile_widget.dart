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
        ? DateFormat('yyyy-MM-dd hh:mm:ss').format(board.createdAt!)
        : '';
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(board.title),
          Text(formattedDate, style: TextStyle(fontSize: 10))
        ],
      ),
      subtitle: Row(
        children: [
          //Text(board.author),
          Text("뷰" + board.views.toString()),
          Text(" | 좋아요" + board.likesCount.toString()),
          Text(" | 댓글 수" + board.commentsCount.toString()),
        ],
      ),
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
      trailing: Text(board.author),
    );
  }
}
