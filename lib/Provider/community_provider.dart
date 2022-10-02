import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:healthin/Service/community_api.dart';

//현재 boardId
final currentBoardIdProvider = StateProvider<String>((ref) {
  List<CommunityBoardsType> boardType = ref.watch(communityBoardsTypeProvider);
  if (boardType.isNotEmpty) {
    log("현재보드아이디를 가져옴");
    return boardType[0].id;
  }
  return "";
});
//현재 postId
final currentPostIdProvider = StateProvider<String>((ref) => "");
//게시판 종류 알려주는 프로바이더
final communityBoardsTypeProvider = StateNotifierProvider<
    CommunityBoardsTypeNotifier,
    List<CommunityBoardsType>>((ref) => CommunityBoardsTypeNotifier());

//그 종류의 게시판 목록 알려주는 프로바이더
final communityBoardsListProvider =
    StateNotifierProvider<CommunityBoardsListNotifier, CommunityBoardsList>(
        (ref) {
  String boardId = ref.watch(currentBoardIdProvider);
  log("현재 게시판 아이디 : $boardId");
  return CommunityBoardsListNotifier(boardId: boardId);
});
//하나의 게시글 정보 알려주는 프로바이더
final communityBoardDataProvider =
    StateNotifierProvider<CommunityBoardDataNotifier, CommunityBoardData>(
        (ref) {
  String boardId = ref.watch(currentBoardIdProvider);
  String postId = ref.watch(currentPostIdProvider);
  return CommunityBoardDataNotifier(boardId: boardId, postId: postId);
});

class CommunityBoardsTypeNotifier
    extends StateNotifier<List<CommunityBoardsType>> {
  CommunityBoardsTypeNotifier([List<CommunityBoardsType>? initialBoardsType])
      : super(initialBoardsType ?? []) {
    log("CommunityBoardsType 초기화");
    getType();
  }

  getType() async {
    log("******CommunityBoardsType 받아오기******");
    state = await getCommunityBoardsType();
    log("*****************************");
  }
  //addtype // deletetype // edittype 등이 올 수 있음
}

class CommunityBoardsListNotifier extends StateNotifier<CommunityBoardsList> {
  String boardId;
  CommunityBoardsListNotifier(
      {required this.boardId, CommunityBoardsList? initialBoardsList})
      : super(initialBoardsList ??
            CommunityBoardsList(boards: [], boardId: boardId, nowPage: 1)) {
    log("CommunityBoardsList 초기화");
    getBoardsList(1);
  }
  getBoardsList(int page) async {
    log("******CommunityBoards 받아오기******");
    List<CommunityBoard> boards =
        await getCommunityBoardList(page, state.limit, boardId);
    log(boards.toString());
    CommunityBoardsList temp = state;
    temp.boards = boards;
    state = temp;
    log("*****************************");
  }
  //
  // addBoards(List<CommunityBoards> data) {
  //   log("CommunityBoards 추가.");
  //   state = [...state, ...data];
  // }
  //
  // deleteBoards(index) {
  //   log("CommunityBoards 삭제.");
  //   state.removeAt(index); //이것도 바꿔야될듯.
  // }

  // editBoards({index, required String props, required int value}) {
  //   log("CommunityBoards 편집.");
  //   CommunityBoards communityBoardsData = state[index];
  //   communityBoardsData[props] = value;
  //   state[index] = communityBoardsData;
  // }
}

class CommunityBoardDataNotifier extends StateNotifier<CommunityBoardData> {
  String postId;

  String boardId;

  CommunityBoardDataNotifier(
      {required this.boardId,
      required this.postId,
      CommunityBoardData? initialBoardData})
      : super(initialBoardData ?? CommunityBoardData()) {
    log("CommunityBoardData 초기화");
  }

  getBoardData() async {
    CommunityBoard boardData = await getCommunityBoardData(boardId, postId);
    CommunityBoardComment commentData =
        await getCommunityBoardComment(boardId, postId);
    log("******CommunityBoardData 받아오기******");
    state = CommunityBoardData(boardData: boardData, comments: [commentData]);
    log("*****************************");
  }
  //
  // addBoardData(CommunityBoardData data) {
  //   log("CommunityBoardData 추가.");
  //   state = data;
  // }
  //
  // deleteBoardData() {
  //   log("CommunityBoardData 삭제.");
  //   state = CommunityBoardData();
  // }
  //
  // editBoardData({required String props, required int value}) {
  //   log("CommunityBoardData 편집.");
  //   CommunityBoardData communityBoardData = state;
  //   communityBoardData[props] = value;
  //   state = communityBoardData;
  // }
}
