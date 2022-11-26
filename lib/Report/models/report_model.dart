// "id": "string",
// "title": "string",
// "year": 0,
// "week": 0

class Report {
  String? id;
  String? title;
  int year;
  int week;

  Report({
    this.id,
    this.title,
    required this.year,
    required this.week,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      week: json['week'],
    );
  }
  factory Report.init() {
    return Report(
      year: DateTime.now().year,
      week: ((DateTime.now()
                  .difference(DateTime(DateTime.now().year, 1, 1))
                  .inDays +
              DateTime(DateTime.now().year, 1, 1).weekday +
              5) ~/
          7),
    );
  }
  toJson() {
    return {
      "year": year,
      "week": week,
    };
  }
}
