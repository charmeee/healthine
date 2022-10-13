class DietModel {
  DietModel({
    required this.photoId,
    required this.results,
  });

  String photoId;
  List<DietResult> results;

  factory DietModel.fromJson(Map<String, dynamic> json) => DietModel(
        photoId: json["photoId"],
        results: List<DietResult>.from(
            json["results"].map((x) => DietResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "photoId": photoId,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class DietResult {
  DietResult({
    required this.name,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
    this.sodium,
    required this.calories,
  });

  String? name;
  int? carbohydrate;
  int? protein;
  int? fat;
  int? sodium;
  int? calories;

  factory DietResult.fromJson(Map<String, dynamic> json) => DietResult(
        name: json["name"],
        carbohydrate: json["carbohydrate"],
        protein: json["protein"],
        fat: json["fat"],
        sodium: json["sodium"],
        calories: json["calories"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
        "sodium": sodium,
        "calories": calories,
      };
}
