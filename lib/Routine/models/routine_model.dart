// Schema
// {
// "id": "string",
// "title": "string",
// "description": "string",
// "author": "string",
// "owner": "string",
// "days": [
// "string"
// ],
// "status": "string",
// "manuals": [
// "string"
//
// No links],
// // "types": [
// // "string"
// // ],
// // "createdAt": "2022-10-15T13:08:54.255Z",
// // "updatedAt": "2022-10-15T13:08:54.255Z"
// // }
class Routine {
  Routine({
    required this.id,
    required this.title,
    this.description,
    this.author,
    this.owner,
    this.days,
    this.status,
    this.manuals,
    this.types,
    required this.createdAt,
    this.updatedAt,
  });

  String id;
  String title;
  String? description;
  String? author;
  String? owner;
  List<String>? days;
  String? status;
  List<String>? manuals;
  List<String>? types;
  DateTime createdAt;
  DateTime? updatedAt;

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        author: json["author"],
        owner: json["owner"],
        days: List<String>.from(json["days"].map((x) => x)),
        status: json["status"],
        manuals: List<String>.from(json["manuals"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
