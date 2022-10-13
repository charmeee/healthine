import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Community/providers/community_provider.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:healthin/Community/services/community_api.dart';
import 'package:intl/intl.dart';
import '../screens/community_detail_screen.dart';
import 'comunity_listTile_widget.dart';

class CommunityMainBodyLayout extends StatefulWidget {
  const CommunityMainBodyLayout(
      {Key? key, required this.boardId, required this.boardTitle})
      : super(key: key);
  final String boardId;
  final String boardTitle;
  @override
  State<CommunityMainBodyLayout> createState() =>
      _CommunityMainBodyLayoutState();
}

class _CommunityMainBodyLayoutState extends State<CommunityMainBodyLayout> {
  static const _pageSize = 20;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  final PagingController<int, CommunityBoard> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await getCommunityBoardList(pageKey, _pageSize, widget.boardId);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedListView<int, CommunityBoard>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<CommunityBoard>(
            itemBuilder: (context, item, index) => MainCommunityListTile(
              board: item,
              boardId: widget.boardId,
            ),
          ),
          separatorBuilder: (context, index) =>
              const Divider(height: 10, color: Colors.indigo)),
    );
  }
}

// class CommunityMainBodyLayout1 extends ConsumerWidget {
//   const CommunityMainBodyLayout1(
//       {Key? key, required this.boardId, required this.boardTitle})
//       : super(key: key);
//   final String boardId;
//   final String boardTitle;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     List<CommunityBoardsList> allBoards = ref.watch(communityProvider);
//     List<CommunityBoard> nowBoards = [];
//     var refreshKey = GlobalKey<RefreshIndicatorState>();
//     for (int i = 0; i < allBoards.length; i++) {
//       if (allBoards[i].boardId == boardId) {
//         nowBoards = allBoards[i].boards;
//       }
//     }
//     if (nowBoards.isEmpty) {
//       return Center(child: CircularProgressIndicator());
//     } else {
//       return RefreshIndicator(
//         key: refreshKey,
//         onRefresh: () async {
//           await ref.read(communityProvider.notifier).reloadBoard(boardId);
//         },
//         child: ListView.separated(
//           itemCount: nowBoards.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(nowBoards[index].title),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CommunityDetail(
//                               boardId: boardId,
//                               postId: nowBoards[index].id,
//                               boardTitle: boardTitle,
//                             )));
//               },
//               trailing: Text(nowBoards[index].author),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) => Divider(
//             height: 10,
//             color: Colors.indigo,
//           ),
//         ),
//       );
//     }
//   }
// }
