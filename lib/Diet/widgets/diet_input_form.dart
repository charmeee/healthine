import 'package:flutter/material.dart';

import '../models/diet_model.dart';

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
      )),
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
                labelText: '식단 설명',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '식단 설명을 입력해주세요.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
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
