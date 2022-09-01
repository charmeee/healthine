class CommunityBoardData {
  String id;
  String nickname;
  String title;
  String content;
  List comment = [];
  String? type = "all";
  CommunityBoardData(
      {required this.id,
      required this.nickname,
      required this.title,
      required this.content,
      required this.comment,
      this.type});
  CommunityBoardData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nickname = json['nickname'],
        title = json['title'],
        content = json['content'],
        comment = json['comments'] ?? [],
        type = json['type'];
}

class CommunityBoardsList {
  //id list ,page,
  String id;
  String nickname;
  String title;
  String? type = "all";
  CommunityBoardsList(
      {required this.id,
      required this.nickname,
      required this.title,
      this.type = "all"});
  CommunityBoardsList.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nickname = json['nickname'],
        title = json['title'],
        type = json['type'];
}
