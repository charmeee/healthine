//게시글 목록 분류
class CommunityBoardsType {
  String id;
  String? slug;
  String title;
  String? description;
  CommunityBoardsType(
      {required this.id, this.slug, required this.title, this.description});
  CommunityBoardsType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        slug = json['slug'],
        title = json['title'],
        description = json['description'];
}

//게시글 목록
// class CommunityBoardsList {
//   //provider
//   String boardId;
//   int nowPage = 1;
//   int limit = 20;
//   List<CommunityBoard> boards;
//   CommunityBoardsList(
//       {required this.nowPage,
//       this.limit = 20,
//       required this.boardId,
//       required this.boards});
//   CommunityBoardsList.fromJson(Map<String, dynamic> json)
//       : nowPage = json['nowPage'],
//         limit = json['limit'],
//         boardId = json['boardId'],
//         boards = (json['boards'] as List<dynamic>)
//             .map((e) => CommunityBoard.fromJson(e))
//             .toList();
// }

//특정 게시물 데이터
class CommunityBoardData {
  CommunityBoard? boardData;
  List<CommunityBoardComment>? comments;

  CommunityBoardData({this.boardData, this.comments});
  //boards/{boardId}/posts/{postId}

  CommunityBoardData.fromJson(Map<String, dynamic> json)
      : boardData = CommunityBoard.fromJson(json['boardData']),
        comments = (json['comments'] == null || json['comments'].isEmpty)
            ? []
            : (json['comments'] as List<dynamic>)
                .map((e) => CommunityBoardComment.fromJson(e))
                .toList();
}

// {
// "id": "string",
// "content": "string",
// "postId": "string",
// "replyId": "string",
// "author": "string",
// "createdAt": "2022-11-02T08:24:13.032Z",
// "updatedAt": "2022-11-02T08:24:13.032Z"
// }

//게시물 코멘트
class CommunityBoardComment {
  //boards/{boardId}/posts/{postId}/comments
  String id;
  String content;
  String author;
  String? replyId;
  DateTime createdAt;
  DateTime? updatedAt;
  CommunityBoardComment({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
    this.replyId,
    this.updatedAt,
  });
  CommunityBoardComment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        author = json['author'],
        replyId = json['replyId'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null;
}

class CommunityBoard {
  //게시글 목록 조회
  //boards/{boardId}/posts
  //Todo: 사진 리스트
  String id;
  String author;
  String title;
  int likesCount;
  int views;
  int? commentsCount;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  CommunityBoard(
      {required this.id,
      required this.author,
      required this.title,
      this.commentsCount,
      this.content,
      required this.likesCount,
      required this.views,
      this.createdAt,
      this.updatedAt});
  CommunityBoard.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        title = json['title'],
        commentsCount = json['commentsCount'],
        content = json['content'] ?? "",
        likesCount = json['likesCount'] ?? 0,
        views = json['views'] ?? 0,
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null;
}
