import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/buttonStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Diet/providers/diet_provider.dart';

import '../models/diet_model.dart';
import '../services/diet_api.dart';
import 'diet_type_chip.dart';

const textFormHeight = 50.0;

const Map<String, String> labelType = {
  "name": "",
  "carbohydrate": "g",
  "protein": "g",
  "fat": "g",
  "sodium": "mg",
  "calories": "kcal"
};

class DietTextForm extends ConsumerStatefulWidget {
  final String photoId;
  final Function(DietType dietType) setDietType;
  final DietType nowDietType;
  const DietTextForm(
      {Key? key,
      required this.photoId,
      required this.setDietType,
      required this.nowDietType})
      : super(key: key);

  @override
  ConsumerState createState() => _DietTextFormState();
}

class _DietTextFormState extends ConsumerState<DietTextForm> {
  final formKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();

  NutritionResult nutritionResult = NutritionResult(name: "", sodium: 0);
  //ref.watch(selectedDietProvider);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${now.month}월 ${now.day}일 식단등록",
                    style: h3Bold_18,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                          SvgPicture.asset("assets/icons/close_withborder.svg"))
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: DietTypeChips(
                  setDietType: widget.setDietType,
                  nowDietType: widget.nowDietType),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "음식 이름",
                      style: bodyRegular_14.copyWith(color: lightGrayColor),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      style: bodyRegular_14,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mediumGrayColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor))),
                      onSaved: (String? value) {
                        setState(() {
                          nutritionResult.name = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '음식 이름을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "칼로리",
                            style:
                                bodyRegular_14.copyWith(color: lightGrayColor),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: bodyRegular_14,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: mediumGrayColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor))),
                            onSaved: (String? value) {
                              setState(() {
                                nutritionResult.calories = int.parse(value!);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '칼로리를 입력해주세요.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "탄수화물",
                            style:
                                bodyRegular_14.copyWith(color: lightGrayColor),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: bodyRegular_14,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: mediumGrayColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor))),
                            onSaved: (String? value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  nutritionResult.carbohydrate = 0;
                                });
                              } else {
                                setState(() {
                                  nutritionResult.carbohydrate =
                                      double.parse(value);
                                });
                              }
                            },
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "단백질",
                            style:
                                bodyRegular_14.copyWith(color: lightGrayColor),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: bodyRegular_14,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: mediumGrayColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor))),
                            onSaved: (String? value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  nutritionResult.protein = 0;
                                });
                              } else {
                                setState(() {
                                  nutritionResult.protein = double.parse(value);
                                });
                              }
                            },
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "지방",
                            style:
                                bodyRegular_14.copyWith(color: lightGrayColor),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: bodyRegular_14,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: mediumGrayColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor))),
                            onSaved: (String? value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  nutritionResult.fat = 0;
                                });
                              } else {
                                setState(() {
                                  nutritionResult.fat = double.parse(value);
                                });
                              }
                            },
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await postDiet(DietDetailResult.fromDietResult(
                        nutritionResult,
                        describeEnum(widget.nowDietType),
                        widget.photoId));
                    ref.refresh(todayDietProvider); //getData
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('식단이 등록되었습니다.')),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
                style: primaryButton,
                child: const Text('식단 등록'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//Map<String,String?> labelType

class CustomTextField extends StatefulWidget {
  final String labelType;
  final String? labelUnit;
  final bool isNum;
  const CustomTextField(
      {Key? key,
      required this.labelType,
      required this.isNum,
      required this.labelUnit})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textFormHeight,
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: '식단 이름',
          border: OutlineInputBorder(),
          suffixText: "",
        ),
        onSaved: (String? value) {
          //ref.read(selectedDietProvider).state = value;
        },
        keyboardType: widget.isNum ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            switch (widget.labelType) {
              case "name":
                return '식단 이름을 입력해주세요.';
              case "calories":
                return '칼로리를 등록해 주세요';
              case "carbohydrate":
                return '탄수화물을 등록해 주세요';
              case "protein":
                return '단백질을 등록해 주세요';
              case "fat":
                return '지방을 등록해 주세요';
              case "sodium":
                return '나트륨을 등록해 주세요';
              default:
                return "값을 입력해 주세요";
            }
          }
          return null;
        },
      ),
    );
  }
}
