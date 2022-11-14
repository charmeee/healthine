import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/diet_model.dart';
import '../models/diet_processed_model.dart';
import '../services/diet_api.dart';
import 'diet_provider.dart';

final dietCardProvider = Provider((ref) {
  final todayDiet = ref.watch(todayDietProvider);
  List<int> nutrientListPerGram = [
    ((todayDiet?.statistics.carbohydrate ?? 0) * 1000).toInt(),
    ((todayDiet?.statistics.protein ?? 0) * 1000).toInt(),
    ((todayDiet?.statistics.fat ?? 0) * 1000).toInt()
  ];
  List<Map<String, dynamic>> dietImgPerType = [];
  if (todayDiet != null) {
    if (todayDiet.meals.breakfast.isNotEmpty) {
      for (DietDetailResult data in todayDiet.meals.breakfast) {
        if (data.photoId != "") {
          dietImgPerType
              .add({"type": DietType.breakfast.korName, "img": data.photoId});
        }
      }
    }
    if (todayDiet.meals.lunch.isNotEmpty) {
      for (DietDetailResult data in todayDiet.meals.lunch) {
        if (data.photoId != "") {
          dietImgPerType
              .add({"type": DietType.lunch.korName, "img": data.photoId});
        }
      }
    }
    if (todayDiet.meals.dinner.isNotEmpty) {
      for (DietDetailResult data in todayDiet.meals.dinner) {
        if (data.photoId != "") {
          dietImgPerType
              .add({"type": DietType.dinner.korName, "img": data.photoId});
        }
      }
    }
    if (todayDiet.meals.snack.isNotEmpty) {
      for (DietDetailResult data in todayDiet.meals.snack) {
        if (data.photoId != "") {
          dietImgPerType
              .add({"type": DietType.snack.korName, "img": data.photoId});
        }
      }
    }
  }

  log(dietImgPerType.toString());
  return DietCardData(
      totalCalories: todayDiet?.statistics.calories ?? 0,
      nutrientListPerGram: nutrientListPerGram,
      dietImgPerType: dietImgPerType);
});
