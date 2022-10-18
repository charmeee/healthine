import 'dart:developer';

enum DietType { breakfast, lunch, dinner, snack }

class DietPhotoResult {
  DietPhotoResult({
    required this.photoId,
    required this.results,
  });

  String photoId;
  List<DietResult> results;

  DietPhotoResult.fromJson(Map<String, dynamic> json)
      : photoId = json["photoId"],
        results = (json["results"] as List<dynamic>)
            .map((e) => DietResult.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        "photoId": photoId,
        "results":
            List<Map<String, Object>>.from(results.map((x) => x.toJson())),
      };
}

class DietResult {
  DietResult({
    required this.name,
    this.carbohydrate,
    this.protein,
    this.fat,
    this.sodium,
    this.calories,
  });

  String name = "";
  double? carbohydrate;
  double? protein;
  double? fat;
  double? sodium;
  int? calories;

  DietResult.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        carbohydrate = json["carbohydrate"],
        protein = json["protein"],
        fat = json["fat"],
        sodium = json["sodium"],
        calories = json["calories"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
        "sodium": sodium,
        "calories": calories,
      };
}

class DayDiet extends DietResult {
  DayDiet({
    required this.type,
    required this.photoId,
  }) : super(
          name: "",
          carbohydrate: 0,
          protein: 0,
          fat: 0,
          sodium: 0,
          calories: 0,
        );

  DateTime date = DateTime.now();
  String type;
  String photoId;

  DayDiet.fromDietResult(DietResult dietResult, this.type, this.photoId)
      : super(
          name: dietResult.name,
          carbohydrate: dietResult.carbohydrate,
          protein: dietResult.protein,
          fat: dietResult.fat,
          sodium: dietResult.sodium,
          calories: dietResult.calories,
        );
  DayDiet.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json["date"]),
        type = json["type"],
        photoId = json["photoId"],
        super(
          name: json["title"],
          carbohydrate: json["carbohydrate"],
          protein: json["protein"],
          fat: json["fat"],
          sodium: json["sodium"],
          calories: json["calories"],
        );

  @override
  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "type": type,
        "photoId": photoId,
        "title": name,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
        "sodium": sodium,
        "calories": calories,
      };
}
