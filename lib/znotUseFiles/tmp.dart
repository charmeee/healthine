// //게시글 목록 분류
// class CommunityBoardsType {
//   String id;
//   String? slug;
//   String title;
//   String? description;
//   CommunityBoardsType(
//       {required this.id, this.slug, required this.title, this.description});
//   CommunityBoardsType.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         slug = json['slug'],
//         title = json['title'],
//         description = json['description'];
// }
//
// //게시글 목록
// class CommunityBoardsList {
//   //provider
//   String boardId;
//   int nowPage = 1;
//   int limit = 20;
//   List<CommunityBoard> boards;
//   CommunityBoardsList(
//       {required this.nowPage,
//         this.limit = 20,
//         required this.boardId,
//         required this.boards});
//   CommunityBoardsList.fromJson(Map<String, dynamic> json)
//       : nowPage = json['nowPage'],
//         limit = json['limit'],
//         boardId = json['boardId'],
//         boards = (json['boards'] as List<dynamic>)
//             .map((e) => CommunityBoard.fromJson(e))
//             .toList();
// }
//
// // communityboardcontent={"id": "string",
// // "title": "string",
// // "content": "string",
// // "author": "string",
// // "images": [
// // "string"
// // ],
// // "likesCount": 0,
// // "commentsCount": 0,
// // "boardId": "string",
// // "hasImages": true,
// // "createdAt": "2022-10-25T19:45:31.319Z",
// // "updatedAt": "2022-10-25T19:45:31.319Z"
// // }}
// //자세한 게시글 컨텐트
// class CommunityBoardContent {
//   String id;
//   String title;
//   String content;
//   String author;
//   List<String> images;
//   int likesCount;
//   int commentsCount;
//   String boardId;
//   bool hasImages;
//   DateTime createdAt;
//   DateTime? updatedAt;
//   CommunityBoardContent(
//       {required this.id,
//         required this.title,
//         required this.content,
//         required this.author,
//         required this.images,
//         this.likesCount = 0,
//         this.commentsCount = 0,
//         required this.boardId,
//         required this.hasImages,
//         required this.createdAt,
//         this.updatedAt});
//   CommunityBoardContent.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         title = json['title'],
//         content = json['content'],
//         author = json['author'],
//         images = json['images'],
//         likesCount = json['likesCount'],
//         commentsCount = json['commentsCount'],
//         boardId = json['boardId'],
//         hasImages = json['hasImages'],
//         createdAt = DateTime.parse(json['createdAt']),
//         updatedAt = DateTime.parse(json['updatedAt']);
// }
//
// //특정 게시물 데이터
// class CommunityBoardData {
//   CommunityBoardContent boardContent;
//   List<CommunityBoardComment>? comments;
//
//   CommunityBoardData({required this.boardContent, this.comments});
// //boards/{boardId}/posts/{postId}
// }
//
// //게시물 코멘트
// class CommunityBoardComment {
//   //boards/{boardId}/posts/{postId}/comments
//   String id;
//   String content;
//   String author;
//   DateTime createdAt;
//   DateTime? updatedAt;
//   CommunityBoardComment({
//     required this.id,
//     required this.content,
//     required this.author,
//     required this.createdAt,
//     this.updatedAt,
//   });
//   CommunityBoardComment.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         content = json['content'],
//         author = json['author'],
//         createdAt = DateTime.parse(json['createdAt']),
//         updatedAt = json['updatedAt'] != null
//             ? DateTime.parse(json['updatedAt'])
//             : null;
// }
//
// // "id": "string",
// // "title": "string",
// // "author": "string",
// // "likesCount": 0,
// // "commentsCount": 0,
// // "views": 0,
// // "hasImages": true,
// // "createdAt": "2022-10-25T09:05:18.346Z"
//
// class CommunityBoard {
//   //게시글 목록 조회
//   //boards/{boardId}/posts
//   String id;
//   String author;
//   String title;
//   int view;
//   int likesCount;
//   bool hasImages;
//   DateTime createdAt;
//   DateTime? updatedAt;
//   CommunityBoard(
//       {required this.id,
//         required this.author,
//         required this.title,
//         required this.createdAt,
//         required this.view,
//         required this.hasImages,
//         this.likesCount = 0,
//         this.updatedAt});
//   CommunityBoard.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         author = json['author'],
//         title = json['title'],
//         createdAt = DateTime.parse(json['createdAt']),
//         updatedAt = DateTime.parse(json['updatedAt']),
//         view = json['view'],
//         likesCount = 0,
//         hasImages = json['hasImages'];
// }
