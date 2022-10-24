import 'package:flutter/material.dart';

import '../models/diet_model.dart';

const textFormHeight = 50.0;

const Map<String, String> labelType = {
  "name": "",
  "carbohydrate": "g",
  "protein": "g",
  "fat": "g",
  "sodium": "mg",
  "calories": "kcal"
};

class DietTextForm extends StatefulWidget {
  const DietTextForm({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _DietTextFormState();
}

class _DietTextFormState extends State<DietTextForm> {
  final formKey = GlobalKey<FormState>();

  //ref.watch(selectedDietProvider);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: '식단 이름',
                border: OutlineInputBorder(),
              ),
              onSaved: (String? value) {
                //ref.read(selectedDietProvider).state = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '식단 이름을 입력해주세요.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '식단 칼로리',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '식단 칼로리를 등록해 주세요';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '식단 칼로리',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '식단 칼로리를 등록해 주세요';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '식단 칼로리',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '식단 칼로리를 등록해 주세요';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '식단 칼로리',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '식단 칼로리를 등록해 주세요';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('식단이 등록되었습니다.')),
                  );
                }
              },
              child: const Text('식단 등록'),
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
