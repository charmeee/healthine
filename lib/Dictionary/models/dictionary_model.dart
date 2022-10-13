class DictionaryData {
  String id;
  String title;
  String enTitle;
  String type;
  // int? difficulty;
  List? description;
  // List? precautions;

  DictionaryData({
    required this.id,
    required this.title,
    required this.enTitle,
    required this.type,
    // this.difficulty,
    this.description,
    //this.precautions
  });
  DictionaryData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        enTitle = json['enTitle'],
        type = json['type'],
        // difficulty = json['difficulty'],
        description = json['description'].split('\n');
  //precautions = json['precautions'];
}
