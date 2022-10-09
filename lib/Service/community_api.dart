import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:http/http.dart' as http;

import 'package:healthin/Model/routine_models.dart';

import 'dio/dio_main.dart';

//게시글 정보 조회
Future<CommunityBoard> getCommunityBoardData(
    String boardId, String postId) async {
  try {
    final response = await dio.get("/boards/${boardId}/posts/${postId}",
        options: Options(headers: {"Authorization": "true"}));
    if (response.statusCode == 200) {
      log("게시글 정보 조회 완료");
      log(response.data.toString());
      return CommunityBoard.fromJson(response.data);
    } else {
      log("커뮤니티 정보가져오기 오류");
      throw Exception(response.data);
    }
  } catch (e) {
    throw Exception(e);
  }
}

///boards/{boardId}/posts
Future<bool> postCommunityBoardData(
    String boardId, String title, String content) async {
  try {
    final response = await dio.post("/boards/${boardId}/posts",
        options: Options(headers: {"Authorization": "true"}),
        data: {"title": title, "content": content});
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("게시글 정보 조회 완료");
      log(response.data.toString());
      return true;
    } else {
      log("커뮤니티 정보가져오기 오류");
      throw Exception(response.data);
    }
  } catch (e) {
    throw Exception(e);
  }
}

//게시글 댓글 조회
Future<List<CommunityBoardComment>> getCommunityBoardComment(
    String boardId, String postId) async {
  ///boards/{boardId}/posts/{postId}/comments
  try {
    final response = await dio.get(
        "/boards/${boardId}/posts/${postId}/comments",
        options: Options(headers: {"Authorization": "true"}));
    if (response.statusCode == 200) {
      log("게시글 댓글 조회 완료");
      List<CommunityBoardComment> communityBoardCommentList = [];
      log(response.data.toString());
      try {
        for (var item in response.data["items"]) {
          communityBoardCommentList.add(CommunityBoardComment.fromJson(item));
        }
        return communityBoardCommentList;
      } catch (e) {
        throw Exception(e);
      }
    } else {
      log("게시글 댓글 가져오기 오류");
      throw Exception(response.data);
    }
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
  try {
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
  } catch (e) {
    throw Exception(e);
  }
}

//커뮤니티 분류 정보
Future<List<CommunityBoardsType>> getCommunityBoardsType() async {
  try {
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
  } catch (e) {
    throw Exception(e);
  }
}
