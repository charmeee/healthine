import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:healthin/Community/services/community_api.dart';
import 'package:intl/intl.dart';
import '../../Common/styles/textStyle.dart';
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
      log(error.toString());
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          decoration: borderContainer.copyWith(
                              border: Border.all(color: bulletRedColor),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text("공지", style: captionRegular_10)),
                      SizedBox(width: 8),
                      Text(
                        "공지사항입니다. 읽어주시기 바랍니다.",
                        style: bodyRegular_14,
                      )
                    ],
                  ),
                )),
            const Divider(height: 1, color: mediumGrayColor),
            Expanded(
              child: PagedListView<int, CommunityBoard>.separated(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<CommunityBoard>(
                    itemBuilder: (context, item, index) =>
                        MainCommunityListTile(
                      board: item,
                      boardId: widget.boardId,
                      refreshKey: refreshKey,
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: mediumGrayColor)),
            ),
          ],
        ),
      ),
    );
  }
}
