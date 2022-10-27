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
    String formattedDate =
        DateFormat('yyyy-MM-dd kk:mm').format(board.createdAt);
    return ListTile(
      title: Text(board.title),
      subtitle: Text(formattedDate),
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
