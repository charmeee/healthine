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
    return FutureBuilder<DietAiPhotoAnalysis>(
        future: getDietDataByAi(image), //<List<DietResult>>
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.results.length + 1,
                itemBuilder: (context, index) {
                  if (index == snapshot.data!.results.length) {
                    //마지막에 식단추가 버튼.
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

class DietSelectTile extends ConsumerWidget {
  final NutritionResult item;
  final String photoId;
  const DietSelectTile({Key? key, required this.item, required this.photoId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: Colors.white,
      onTap: () async {
        //alert창 띄우기
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('식단 추가'),
                content: const Text('식단을 추가하시겠습니까?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('취소')),
                  TextButton(
                      onPressed: () async {
                        //식단 추가 api
                        await postDiet(DietDetailResult.fromDietResult(
                            item, describeEnum(DietType.breakfast), photoId));
                        ref.refresh(todayDietProvider); //getData
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Diet()),
                            (route) => route.isFirst);
                      },
                      child: const Text('확인')),
                ],
              );
            });
        //post요청을날리고 식단 페이지로 navigate 함
      },
      title: Text(item.name.toString()),
      trailing: Text(item.calories.toString()),
      subtitle:
          Text('탄: ${item.carbohydrate} 단: ${item.protein} 지: ${item.fat}'),
    );
  }
}
