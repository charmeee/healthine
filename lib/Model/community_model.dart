class CommunityBoardsType {
  //provider
  //게시글 분류 목록
  //boards
  //id list ,page,
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

class CommunityBoardsList {
  //provider
  String boardId;
  int nowPage = 1;
  int limit = 20;
  List<CommunityBoard> boards;
  CommunityBoardsList(
      {required this.nowPage,
      this.limit = 20,
      required this.boardId,
      required this.boards});
  CommunityBoardsList.fromJson(Map<String, dynamic> json)
      : nowPage = json['nowPage'],
        limit = json['limit'],
        boardId = json['boardId'],
        boards = (json['boards'] as List<dynamic>)
            .map((e) => CommunityBoard.fromJson(e))
            .toList();
}

//CommunityBoardData
class CommunityBoardData {
  CommunityBoard? boardData;
  List<CommunityBoardComment>? comments;

  CommunityBoardData({this.boardData, this.comments});
  //boards/{boardId}/posts/{postId}

  CommunityBoardData.fromJson(Map<String, dynamic> json)
      : boardData = CommunityBoard.fromJson(json['boardData']),
        comments = (json['comments'] as List<dynamic>)
            .map((e) => CommunityBoardComment.fromJson(e))
            .toList();
}

class CommunityBoardComment {
  //boards/{boardId}/posts/{postId}/comments
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
  CommunityBoardComment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        author = json['author'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null;
}

class CommunityBoard {
  //게시글 목록 조회
  //boards/{boardId}/posts
  String id;
  String author;
  String title;
  String content;
  DateTime createdAt;
  DateTime? updatedAt;
  CommunityBoard(
      {required this.id,
      required this.author,
      required this.title,
      required this.content,
      required this.createdAt,
      this.updatedAt});
  CommunityBoard.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        title = json['title'],
        content = json['content'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
