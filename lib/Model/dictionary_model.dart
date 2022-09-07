class DictionaryData {
  int? id;
  String? name;
  String? enName;
  String? type;
  int? difficulty;
  List? content;
  List? precautions;

  DictionaryData(
      {this.id,
      this.name,
      this.enName,
      this.type,
      this.difficulty,
      this.content,
      this.precautions});
  DictionaryData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        enName = json['enName'],
        type = json['type'],
        difficulty = json['difficulty'],
        content = json['content'],
        precautions = json['precautions'];
}
