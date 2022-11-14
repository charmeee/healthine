class ManualData {
  String id;
  String title;
  String enTitle;
  String type;
  // int? difficulty;
  List? description;
  // List? precautions;

  ManualData({
    required this.id,
    required this.title,
    required this.enTitle,
    required this.type,
    // this.difficulty,
    this.description,
    //this.precautions
  });
  ManualData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        enTitle = json['enTitle'],
        type = json['type'],
        // difficulty = json['difficulty'],
        description = (json['description'] ?? "").split('\n');
  //precautions = json['precautions'];
}
