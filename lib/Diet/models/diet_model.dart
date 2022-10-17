import 'dart:developer';

class DietModel {
  DietModel({
    required this.photoId,
    required this.results,
  });

  String photoId;
  List<DietResult> results;

  DietModel.fromJson(Map<String, dynamic> json)
      : photoId = json["photoId"],
        results = (json["results"] as List<Map<String, Object>>)
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

  String name;
  double? carbohydrate;
  double? protein;
  double? fat;
  double? sodium;
  double? calories;

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
