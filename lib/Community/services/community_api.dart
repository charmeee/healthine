import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Common/dio/dio_main.dart';
import 'package:healthin/Community/models/community_model.dart';

//게시글 정보 조회
Future<CommunityBoard> getCommunityBoardData(
    String boardId, String postId) async {
  final response = await dio.get("/boards/${boardId}/posts/${postId}",
      options: Options(headers: {"Authorization": "true"}));

  log("게시글 정보 조회 완료");
  log(response.data.toString());
  try {
    return CommunityBoard.fromJson(response.data);
  } catch (e) {
    log("게시글 정보 조회 오류");
    log("error: $e");
    throw Exception(e);
  }
}

//좋아요 누르기
Future<bool> postLikes(String boardId, String postId) async {
  final response = await dio.post("/boards/${boardId}/posts/${postId}/like",
      options: Options(headers: {"Authorization": "true"}), data: {});
  log("좋아요 완료");
  log(response.data.toString());
  return response.data;
}

//대댓글post /boards/{boardId}/posts/{postId}/comments/{replyId}
Future<void> postReplyComment(
    String boardId, String postId, String replyId, String content) async {
  final response = await dio.post(
      "/boards/${boardId}/posts/${postId}/comments/${replyId}",
      data: {"content": content},
      options: Options(headers: {"Authorization": "true"}));
  log("대댓글 완료");
  log(response.data.toString());
}

///boards/{boardId}/posts
Future<bool> postCommunityBoardData(
    String boardId, String title, String content) async {
  try {
    final response = await dio.post("/boards/${boardId}/posts",
        options: Options(headers: {"Authorization": "true"}),
        data: {"title": title, "content": content});
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("게시글 post 완료");
      log(response.data.toString());
      return true;
    } else {
      log("게시글 post 오류");
      throw Exception(response.data);
    }
  } catch (e) {
    return false;
  }
}

//게시글 댓글 조회
Future<List<CommunityBoardComment>> getCommunityBoardComment(
    String boardId, String postId) async {
  ///boards/{boardId}/posts/{postId}/comments
  final response = await dio.get("/boards/${boardId}/posts/${postId}/comments",
      options: Options(headers: {"Authorization": "true"}));
  log("게시글 댓글 조회 완료");
  log(response.data.toString());
  List<CommunityBoardComment> communityBoardCommentList = [];

  try {
    if (response.data.isNotEmpty) {
      for (var item in response.data) {
        communityBoardCommentList.add(CommunityBoardComment.fromJson(item));
      }
    }
    return communityBoardCommentList;
  } catch (e) {
    throw Exception(e);
  }
}

//게시글 댓글 보내기
Future<void> postCommunityBoardComment(
    String boardId, String postId, String content) async {
  ///boards/{boardId}/posts/{postId}/comments
  try {
    final response = await dio.post("/boards/$boardId/posts/$postId/comments",
        options: Options(headers: {"Authorization": "true"}),
        data: {
          "content": content,
        });
    log("comment post response : ${response.data}");
    if (response.statusCode == 201) {
      log("게시글 댓글 보내기 완료");
    } else {
      log("게시글 댓글 보내기 오류");
      throw Exception(response.data);
    }
  } catch (e) {
    throw Exception(e);
  }
}

//게시글 목록 조회
Future<List<CommunityBoard>> getCommunityBoardList(
    int page, int limit, String boardId) async {
  final response = await dio.get(
      "/boards/$boardId/posts?page=$page&limit=$limit",
      options: Options(headers: {"Authorization": "true"}));
  if (response.statusCode == 200) {
    log("게시글 목록 조회 완료");
    List<CommunityBoard> communityBoardList = [];
    try {
      log(response.data["items"].toString());
      for (var item in response.data["items"]) {
        communityBoardList.add(CommunityBoard.fromJson(item));
      }
      return communityBoardList;
    } catch (e) {
      throw Exception(e);
    }
  } else {
    log("커뮤니티 정보가져오기 오류");
    throw Exception(response.data);
  }
}

//커뮤니티 분류 정보
Future<List<CommunityBoardsType>> getCommunityBoardsType() async {
  final response = await dio.get("/boards",
      options: Options(headers: {"Authorization": "true"}));
  if (response.statusCode == 200) {
    log("커뮤니티 분류 정보가져오기 완료");
    log(response.data["items"].toString());
    List<CommunityBoardsType> communityBoardsTypeList = [];
    try {
      for (var item in response.data["items"]) {
        communityBoardsTypeList.add(CommunityBoardsType.fromJson(item));
      }
      return communityBoardsTypeList;
    } catch (e) {
      throw Exception(e);
    }
    //return _communityList;
  } else {
    log("커뮤니티 정보가져오기 오류");
    throw Exception(response.statusCode);
  }
}
