import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:image_picker/image_picker.dart';

import '../models/diet_model.dart';
import '../providers/diet_provider.dart';
import '../services/diet_api.dart';
import 'diet_input_form.dart';

class DietResultWidget extends StatefulWidget {
  final XFile image;
  final Function(DietType dietType) setDietType;
  final DietType nowDietType;
  const DietResultWidget(
      {Key? key,
      required this.image,
      required this.setDietType,
      required this.nowDietType})
      : super(key: key);

  @override
  State<DietResultWidget> createState() => _DietResultWidgetState();
}

class _DietResultWidgetState extends State<DietResultWidget> {
  DietAiPhotoAnalysis? dietAiPhotoAnalysis;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDietResult();
  }

  getDietResult() async {
    DietAiPhotoAnalysis tmp = await getDietDataByAi(widget.image);
    setState(() {
      dietAiPhotoAnalysis = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dietAiPhotoAnalysis == null) {
      return const Center(
          child: Text(
        "식단을 분석 중 입니다.",
        style: bodyBold_16,
      ));
    }

    return ResultListView(
      data: dietAiPhotoAnalysis!,
      setDietType: widget.setDietType,
      nowDietType: widget.nowDietType,
    );
  }
}

class ResultListView extends ConsumerStatefulWidget {
  final DietAiPhotoAnalysis data;
  final Function(DietType dietType) setDietType;
  final DietType nowDietType;
  const ResultListView(
      {Key? key,
      required this.data,
      required this.setDietType,
      required this.nowDietType})
      : super(key: key);

  @override
  ConsumerState createState() => _ResultListViewState();
}

class _ResultListViewState extends ConsumerState<ResultListView> {
  int selectedChipIndex = 0;

  setItem(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data.results.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text('AI 추천 단탄지 정보', style: h3Bold_18),
            );
          }
          if (index == widget.data.results.length + 1) {
            //마지막에 식단추가 버튼.
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 56,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: primaryColor),
                        ),
                      ),
                      onPressed: () {
                        showBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return DietTextForm(
                                photoId: widget.data.photoId,
                                setDietType: widget.setDietType,
                                nowDietType: widget.nowDietType,
                              );
                            });
                        //바텀시트열ㅔㅐ
                      },
                      child: Text(
                        '직접입력',
                        style: bodyBold_16.copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        if (selectedChipIndex != 0) {
                          await postDiet(DietDetailResult.fromDietResult(
                              widget.data.results[selectedChipIndex - 1],
                              describeEnum(widget.nowDietType),
                              widget.data.photoId));
                          ref.refresh(todayDietProvider); //getData
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('식단을 선택해주세요.')));
                        }
                      },
                      child: const Text('식단 추가', style: bodyBold_16),
                    ),
                  ),
                ],
              ),
            );
          }
          return DietSelectTile(
            item: widget.data.results[index - 1],
            photoId: widget.data.photoId,
            setItem: setItem,
            selectedChipIndex: selectedChipIndex,
            index: index,
          );
        });
  }
}

class DietSelectTile extends StatelessWidget {
  final NutritionResult item;
  final String photoId;
  final Function(int index) setItem;
  final int selectedChipIndex;
  final int index;
  const DietSelectTile(
      {Key? key,
      required this.item,
      required this.photoId,
      required this.setItem,
      required this.selectedChipIndex,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedChipIndex == index) {
          setItem(0);
        } else {
          setItem(index);
        }
      },
      child: Container(
        decoration: filledContainer.copyWith(
            border: (selectedChipIndex == index)
                ? Border.all(color: primaryColor)
                : null),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.name}  ${item.calories.toString()}kcal',
                style: bodyRegular_16),
            SizedBox(height: 8),
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      '탄수화물: ${(item.carbohydrate! * 1000).toInt().toString()}g',
                      style: bodyRegular_14),
                  SizedBox(width: 8),
                  Text('단백질: ${(item.protein! * 1000).toInt().toString()}g',
                      style: bodyRegular_14),
                  SizedBox(width: 8),
                  Text('지방: ${(item.fat! * 1000).toInt().toString()}g',
                      style: bodyRegular_14),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
