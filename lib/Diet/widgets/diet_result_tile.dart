import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:image_picker/image_picker.dart';

import '../models/diet_model.dart';
import '../providers/diet_provider.dart';
import '../screens/diet.dart';
import '../services/diet_api.dart';
import 'diet_input_form.dart';

class DietResultWidget extends StatelessWidget {
  final XFile image;

  const DietResultWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DietPhotoResult>(
        future: getDietDataByAi(image), //<List<DietResult>>
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.results.length + 1,
                itemBuilder: (context, index) {
                  if (index == snapshot.data!.results.length) {
                    return ElevatedButton(
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return DietTextForm();
                            });
                        //바텀시트열ㅔㅐ
                      },
                      child: const Text('식단 추가'),
                    );
                  }
                  return DietSelectTile(
                    item: snapshot.data!.results[index],
                    photoId: snapshot.data!.photoId,
                  );
                });
          } else {
            return const Center(child: Text("식단을 분석 중 입니다."));
          }
        });
  }
}

class DietSelectTile extends StatelessWidget {
  final DietResult item;
  final String photoId;
  const DietSelectTile({Key? key, required this.item, required this.photoId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      onTap: () async {
        await postDietData(DayDiet.fromDietResult(
            item, describeEnum(DietType.breakfast), photoId));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Diet()),
        );
        //post요청을날리고 식단 페이지로 navigate 함
      },
      title: Text(item.name.toString()),
      trailing: Text(item.calories.toString()),
      subtitle:
          Text('탄: ${item.carbohydrate} 단: ${item.protein} 지: ${item.fat}'),
    );
  }
}
