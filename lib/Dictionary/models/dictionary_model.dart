class ManualData {
  String id;
  String title;
  String enTitle;
  String type;
  // int? difficulty;
  String? equipmentTitle;
  String? equipmentId;
  String? equipmentEnTitle;
  List? description;
  String? precaution;
  String? imageUrl;
  String? videoUrl;
  ManualData(
      {required this.id,
      required this.title,
      required this.enTitle,
      required this.type,
      // this.difficulty,
      this.description,
      this.precaution,
      this.equipmentId,
      this.equipmentTitle,
      this.equipmentEnTitle,
      this.imageUrl,
      this.videoUrl});
  ManualData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        enTitle = json['enTitle'],
        type = json['type'],
        // difficulty = json['difficulty'],
        description = (json['description'] ?? "").split('\n'),
        precaution = json['precaution'],
        equipmentId = json['equipmentId'],
        equipmentTitle = json['equipmentTitle'],
        equipmentEnTitle = json['equipmentEnTitle'],
        imageUrl = json['imageUrl'],
        videoUrl = json['videoUrl'];
}
