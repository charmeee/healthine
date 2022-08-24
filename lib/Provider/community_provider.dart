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
import 'package:healthin/Model/models.dart';
import 'package:healthin/Provider/user_provider.dart';

class CommunityNotifier extends StateNotifier<List<CommunityData>> {
  CommunityNotifier() : super([]);
  final myNickname = Provider<String>((ref) {
    final nickname =
        ref.watch(userStateProvider.select((value) => value.nickname));
    return nickname.toString();
  });
  //페이지를 추가한다
  void addPage(CommunityData data) {
    state = [...state, data];
    log("페이지 추가");
    log(state.length.toString());
  }

  //페이지 수정
  void editPage(int id, String title, Map<String, String> content) {
    for (final community in state) {
      if (community.id == id) {
        community.content = content;
        community.title = title;
      }
    }
  }
  //페이지 삭제

  //댓글을 추가한다
  void addComment(int id, myNickname, String commentContent) {
    for (final community in state) {
      if (community.id == id) {
        community.comment = [...?community.comment, commentContent];
        log("댓글 추가 : $commentContent");
      }
    }
  }
  //댓글 삭제
  //댓글 수정
}

final CommunityNotifierProvider =
    StateNotifierProvider<CommunityNotifier, List<CommunityData>>(
        (ref) => CommunityNotifier());
