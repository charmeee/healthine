/*
필요한것
전체페이지 List 형태
id
nickname
title
content
  img / text
comment
  nickname/ comment_content
*/
//add page.
//edit page
//delete page

//add comment
//delete comment
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:healthin/Service/community_api.dart';

class CommunityDataNotifier extends StateNotifier<CommunityBoardData?> {
  CommunityDataNotifier([CommunityBoardData? initialCommunity])
      : super(initialCommunity) {}

  getComunnity(String id) async {
    CommunityBoardData dictionaryData = await readCommmunityDataJson(id);
    state = dictionaryData;
    log(state!.title.toString());
    log("커뮤니티데이터를 받아옴.");
  }

  // //페이지를 추가한다
  // void addPage(CommunityBoardData data) {
  //   state = [...state, data];
  //   log("페이지 추가");
  //   log(state.length.toString());
  // }
  void addComment(String id, String nickname, String text) {
    if (state != null) {
      CommunityBoardData temp = state!;
      temp.comment.add({"id": id, "nickname": nickname, "text": text});
      state = temp;
    }
  }

  //페이지 수정
  void editPage(String id, String title, String content) {
    if (state!.id == id) {
      state!.content = content;
      state!.title = title;
    }
  }
  //페이지 삭제

  // //댓글을 추가한다
  // void addComment(int id, myNickname, String commentContent) {
  //   for (final community in state) {
  //     if (community.id == id) {
  //       community.comment = [...?community.comment, commentContent];
  //       log("댓글 추가 : $commentContent");
  //     }
  //   }
  // }
  //댓글 삭제
  //댓글 수정
}

final CommunityDataNotifierProvider =
    StateNotifierProvider<CommunityDataNotifier, CommunityBoardData?>(
        (ref) => CommunityDataNotifier());

class CommunityListNotifier extends StateNotifier<List<CommunityBoardsList>> {
  CommunityListNotifier([List<CommunityBoardsList>? initialCommunity])
      : super(initialCommunity ?? []) {
    log("커뮤니티리스트데이터 가져오기실행");
    getComunnityList();
  }

  getComunnityList() async {
    List<CommunityBoardsList> dictionaryList = await readCommmunityListJson();
    if (dictionaryList.isNotEmpty) {
      state = dictionaryList;
      log(state[0].title.toString());
      log("커뮤니티리스트데이터를 받아옴.");
    }
  }

  //페이지를 추가한다
  void addPage(CommunityBoardsList data) {
    state = [...state, data];
    log("페이지 추가");
    log(state.length.toString());
  }

  //페이지 수정

  //페이지 삭제

//댓글 삭제
//댓글 수정
}

final CommunityListNotifierProvider =
    StateNotifierProvider<CommunityListNotifier, List<CommunityBoardsList>>(
        (ref) => CommunityListNotifier());
