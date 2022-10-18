import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/diet_model.dart';

final selectedDietProvider =
    StateNotifierProvider<SelectedDietNotifier, List<DietResult>>(
        (ref) => SelectedDietNotifier());

class SelectedDietNotifier extends StateNotifier<List<DietResult>> {
  SelectedDietNotifier() : super([]);

  void addDiet(DietResult diet) {
    log("addDiet:${diet}");
    state = [...state, diet];
  }

  void removeDiet(DietResult diet) {
    log("removeDiet:${diet}");
    state = state.where((element) => element.name != diet.name).toList();
  }
}
