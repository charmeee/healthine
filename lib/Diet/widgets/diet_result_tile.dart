import 'dart:html';

import 'package:flutter/material.dart';

import '../models/diet_model.dart';
import '../services/diet_api.dart';

class DietResultWidget extends StatelessWidget {
  final imagePath;
  final Function(List<DietResult> result) setDietResult;

  const DietResultWidget(
      {Key? key, required this.imagePath, required this.setDietResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DietResult>>(
        future: getDietData(imagePath), //<List<DietResult>>
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // final List<bool> _selected = List.generate(snapshot.data!.length,
            //     (i) => false); // Fill it with false initially
            setDietResult(snapshot.data!);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DietResult item = snapshot.data![index];
                  return ListTile(
                    tileColor: Colors.white,
                    onTap: () {},
                    title: Text(item.name.toString()),
                    trailing: Text(item.calories.toString()),
                    subtitle: Text(
                        '탄: ${item.carbohydrate} 단: ${item.protein} 지: ${item.fat}'),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
