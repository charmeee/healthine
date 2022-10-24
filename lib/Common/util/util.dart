List<String> dayList = ["월", "화", "수", "목", "금", "토", "일"];

List<String> getDayList(List<int> list) {
  List<String> day = [];
  for (int i = 0; i < list.length; i++) {
    if (list[i] == 1) {
      day.add(dayList[i]);
    }
  }
  return day;
}
