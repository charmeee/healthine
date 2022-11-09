class DietCardData {
  int totalCalories;
  List<int> nutrientListPerGram;
  List<Map<String, dynamic>> dietImgPerType;
  DietCardData(
      {required this.totalCalories,
      required this.nutrientListPerGram,
      required this.dietImgPerType});
}
