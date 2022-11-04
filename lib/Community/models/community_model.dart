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

// [{
// "id": "96172339-a210-47c3-898e-c3aeff84b2fc",
// "content": "ㅇㅇㅇㅇ",
// "createdAt": "2022-10-04T08:08:18.448Z",
// "updatedAt": "2022-10-04T08:08:18.448Z",
// "author": "만두",
// "childComments": [
// {
// "id": "1e3cc59c-9763-44d4-b3ee-f3cab6d8d2e1",
// "content": "방가염",
// "createdAt": "2022-11-02T12:04:23.441Z",
// "updatedAt": "2022-11-02T12:04:23.441Z",
// "author": "만두",
// "childComments": null,
// "postId": "ca8fa5e3-d19d-4f09-b257-6f9f55bac23b"
// }
// ],
// "postId": "ca8fa5e3-d19d-4f09-b257-6f9f55bac23b"
// }],
//게시물 코멘트
class CommunityBoardComment {
  //boards/{boardId}/posts/{postId}/comments
  String id;
  String content;
  String author;
  DateTime createdAt;
  DateTime? updatedAt;
  List<CommunityBoardComment>? childComments;
  CommunityBoardComment(
      {required this.id,
      required this.content,
      required this.author,
      required this.createdAt,
      this.updatedAt,
      this.childComments});
  CommunityBoardComment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        author = json['author'],
        createdAt = DateTime.parse(json['createdAt']),
        childComments = json['childComments'] == null
            ? null
            : (json['childComments'] as List<dynamic>)
                .map((e) => CommunityBoardComment.fromJson(e))
                .toList(),
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
