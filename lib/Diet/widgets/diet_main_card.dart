import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/diet_model.dart';
import '../providers/diet_provider.dart';
import '../screens/diet_input_screen.dart';

List<String> nutrition = ["칼로리", "탄수화물", "단백질", "지방"];

class DietCard extends ConsumerWidget {
  const DietCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DayDietStatistics? data = ref.watch(todayDietProvider);
    //data가 null이면 로딩중이라는 뜻

    if (data == null) {
      return Card(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            data.meals.isEmpty
                ? Text('식단이 없습니다.')
                : _buildList(context, data.statistics.getNutritionList()),
            ElevatedButton(
                onPressed: () {
                  //push DietInputScreen()
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DietInputScreen()),
                  );
                },
                child: Text("식단 추가하기")),
          ],
        ),
      );
    }
  }

  Widget _buildList(BuildContext context, List data) {
    return ListView.builder(
      itemCount: 5, //칼로리 탄 단 지.
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: Text('칼로리'),
            trailing: Text('${data[index]}kcal'),
          );
        }
        return ListTile(
          title: Text('${nutrition[index - 1]}: ${data[index - 1]}'),
        );
      },
    );
  }
}
