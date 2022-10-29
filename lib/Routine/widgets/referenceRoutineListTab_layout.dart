import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/screens/routineSetting_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../Common/util/util.dart';
import '../models/routine_models.dart';
import '../providers/routine_provider.dart';
import '../services/referenceRoutine_api.dart';
import 'referenceListTile.dart';

class ReferenceRoutineListTabLayout extends StatefulWidget {
  const ReferenceRoutineListTabLayout({Key? key}) : super(key: key);

  @override
  State<ReferenceRoutineListTabLayout> createState() =>
      _ReferenceRoutineListTabLayoutState();
}

class _ReferenceRoutineListTabLayoutState
    extends State<ReferenceRoutineListTabLayout> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  static const _pageSize = 20;
  final PagingController<int, ReferenceRoutine> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getReferenceRoutineList(pageKey, _pageSize);
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
      child: PagedListView<int, ReferenceRoutine>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ReferenceRoutine>(
          itemBuilder: (context, item, index) => ReferenceRoutineListTile(
            reference: item,
            refreshKey: refreshKey,
          ),
        ),
      ),
    );
  }
}
