import 'dart:developer';

import 'package:intl/intl.dart';

enum DietType { breakfast, lunch, dinner, snack }

extension DietTypeExtension on DietType {
  String get korName {
    switch (this) {
      case DietType.breakfast:
        return '아침';
      case DietType.lunch:
        return '점심';
      case DietType.dinner:
        return '저녁';
      case DietType.snack:
        return '간식';
    }
  }
}

class DietAiPhotoAnalysis {
  //사진으로 분석자료 가져올때쓰는것
  DietAiPhotoAnalysis({
    required this.photoId,
    required this.results,
  });

  String photoId;
  List<NutritionResult> results;

  DietAiPhotoAnalysis.fromJson(Map<String, dynamic> json)
      : photoId = json["photoId"],
        results = (json["results"] as List<dynamic>)
            .map((e) => NutritionResult.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        "photoId": photoId,
        "results":
            List<Map<String, Object>>.from(results.map((x) => x.toJson())),
      };
}

class NutritionResult {
  NutritionResult({
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

  NutritionResult.fromJson(Map<String, dynamic> json)
      : name = json["name"] ?? "",
        carbohydrate = ((json["carbohydrate"] ?? 0).toDouble()) as double,
        protein = ((json["protein"] ?? 0).toDouble()) as double,
        fat = ((json["fat"] ?? 0).toDouble()) as double,
        sodium = ((json["sodium"] ?? 0).toDouble()) as double,
        calories = ((json["calories"] ?? 0).toInt()) as int;

  Map<String, dynamic> toJson() => {
        "name": name,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
        "sodium": sodium,
        "calories": calories,
      };

  List getNutritionList() {
    //칼로리 탄단지
    return [calories, carbohydrate, protein, fat];
  }
}

class DietDetailResult extends NutritionResult {
  DietDetailResult({
    required this.type,
    required this.photoId,
    this.id,
  }) : super(
          name: "",
          carbohydrate: 0,
          protein: 0,
          fat: 0,
          sodium: 0,
          calories: 0,
        );
  String? id;
  DateTime date = DateTime.now();
  String type;
  String photoId;

  DietDetailResult.fromDietResult(
      NutritionResult dietResult, this.type, this.photoId)
      : super(
          name: dietResult.name,
          carbohydrate: dietResult.carbohydrate,
          protein: dietResult.protein,
          fat: dietResult.fat,
          sodium: dietResult.sodium,
          calories: dietResult.calories,
        );
  DietDetailResult.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        date = DateTime.parse(json["date"] ?? DateTime.now().toString()),
        type = json["type"],
        photoId = json["photoId"] ?? "",
        super(
          name: json["title"],
          carbohydrate: (json["carbohydrate"] ?? 0).toDouble(),
          protein: (json["protein"] ?? 0).toDouble(),
          fat: (json["fat"] ?? 0).toDouble(),
          sodium: (json["sodium"] ?? 0).toDouble(),
          calories: json["calories"],
        );

  @override
  Map<String, dynamic> toJson() => {
        "date": DateFormat("yyyy-MM-dd").format(date),
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

// {
//   "statistics": {
//   "carbohydrate": 0.07612999999999999,
//   "protein": 0.00879,
//   "fat": 0.00366,
//   "sodium": 0.000313,
//   "calories": 353
//   },
// "meals": {
//   "breakfast": [
//     {//DayDiet
//     "id": "625345b4-bb2b-4b0c-88cd-021dea7af888",
//     "date": "2022-10-19",
//     "title": "Tteokbokki",
//     "type": "breakfast",
//     "photoId": "1312163f-b2c0-4dbf-ac88-9c003c7d3f15_20221019131409",
//     "carbohydrate": 0.07612999999999999,
//     "protein": 0.00879,
//     "fat": 0.00366,
//     "sodium": 0.000313,
//     "calories": 353
//     }
//   ],
//   "lunch": [],
//   "dinner": [],
//   "snack": []
//   }
// }

class DayDietStatistics {
  DayDietStatistics({
    required this.statistics,
    required this.meals,
  });

  NutritionResult statistics;
  DayDietType meals;

  DayDietStatistics.fromJson(Map<String, dynamic> json)
      : statistics = NutritionResult.fromJson(json["statistics"]),
        meals = DayDietType.fromJson(json["meals"]);

  Map<String, dynamic> toJson() => {
        "statistics": statistics.toJson(),
        "meals": meals.toJson(),
      };
}

class DayDietType {
  DayDietType({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
  });
  List<DietDetailResult> breakfast;
  List<DietDetailResult> lunch;
  List<DietDetailResult> dinner;
  List<DietDetailResult> snack;
  bool get isEmpty {
    return breakfast.isEmpty &&
        lunch.isEmpty &&
        dinner.isEmpty &&
        snack.isEmpty;
  }

  int get dietCount {
    int count = 0;
    if (breakfast.isNotEmpty) count++;
    if (lunch.isNotEmpty) count++;
    if (dinner.isNotEmpty) count++;
    if (snack.isNotEmpty) count++;
    return count;
  }

  DayDietType.fromJson(Map<String, dynamic> json)
      : breakfast = json["breakfast"].isEmpty
            ? []
            : (json["breakfast"] as List<dynamic>)
                .map((e) => DietDetailResult.fromJson(e))
                .toList(),
        lunch = json["lunch"].isEmpty
            ? []
            : (json["lunch"] as List<dynamic>)
                .map((e) => DietDetailResult.fromJson(e))
                .toList(),
        dinner = json["dinner"].isEmpty
            ? []
            : (json["dinner"] as List<dynamic>)
                .map((e) => DietDetailResult.fromJson(e))
                .toList(),
        snack = json["snack"].isEmpty
            ? []
            : (json["snack"] as List<dynamic>)
                .map((e) => DietDetailResult.fromJson(e))
                .toList();

  Map<String, dynamic> toJson() => {
        "breakfast":
            List<Map<String, Object>>.from(breakfast.map((x) => x.toJson())),
        "lunch": List<Map<String, Object>>.from(lunch.map((x) => x.toJson())),
        "dinner": List<Map<String, Object>>.from(dinner.map((x) => x.toJson())),
        "snack": List<Map<String, Object>>.from(snack.map((x) => x.toJson())),
      };
}
