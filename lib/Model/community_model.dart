//CommunityBoardData
class CommunityBoardData {
  // [
  // {
  // "id": "string",
  // "content": "string",
  // "author": "string",
  // "createdAt": "2022-09-29T06:58:40.791Z",
  // "updatedAt": "2022-09-29T06:58:40.791Z"
  // }
  // ]
  //boards/{boardId}/posts/{postId}/comments

  String id;
  String title;
  String content;
  String author;
  String createdAt;
  String? updatedAt;

  CommunityBoardData({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    this.updatedAt,
  });
  //boards/{boardId}/posts/{postId}
  // {
  // "id": "string",
  // "title": "string",
  // "content": "string",
  // "author": "string",
  // "createdAt": "2022-09-29T07:00:58.827Z",
  // "updatedAt": "2022-09-29T07:00:58.827Z"
  // }
}

class CommunityBoardComment {
  String id;
  String content;
  String author;
  DateTime createdAt;
  DateTime? updatedAt;
  CommunityBoardComment({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
    this.updatedAt,
  });
}

class CommunityBoardList {
  //게시글 목록 조회
  // [
  // {
  // "id": "string",
  // "title": "string",
  // "content": "string",
  // "author": "string",
  // "createdAt": "2022-09-29T05:08:47.333Z",
  // "updatedAt": "2022-09-29T05:08:47.333Z"
  // }
  // ]
  String id;
  String author;
  String title;
  String content;
  DateTime createdAt;
  DateTime? updatedAt;
  CommunityBoardList(
      {required this.id,
      required this.author,
      required this.title,
      required this.content,
      required this.createdAt,
      this.updatedAt});
  CommunityBoardList.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        title = json['title'],
        content = json['content'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}

class CommunityBoardsType {
  //게시글 분류 목록
  //id list ,page,
  String id;
  String slug;
  String title;
  String? description = "all";
  CommunityBoardsType(
      {required this.id,
      required this.slug,
      required this.title,
      this.description});
  CommunityBoardsType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        slug = json['slug'],
        title = json['title'],
        description = json['description'];
}
