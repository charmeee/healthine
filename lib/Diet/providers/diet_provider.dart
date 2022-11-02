import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/diet_model.dart';
import '../services/diet_api.dart';

//오늘 먹은 식단 정보를 저장하고 있으면 좋을듯? 덜 요청해두되고
final todayDietProvider =
    StateNotifierProvider<DietStatisticsNotifier, DayDietStatistics?>(
        (ref) => DietStatisticsNotifier());

class DietStatisticsNotifier extends StateNotifier<DayDietStatistics?> {
  DietStatisticsNotifier() : super(null) {
    getData();
  }

  Future getData() async {
    DateTime now = DateTime.now();
    state = await getDietStatistics(now);
  }

  Future<DayDietStatistics?> getAnotherData(selectedDay) async {
    try {
      return await getDietStatistics(selectedDay);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
