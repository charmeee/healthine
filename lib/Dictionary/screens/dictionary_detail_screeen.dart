import 'package:flutter/material.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:healthin/Routine/models/routine_models.dart';

class DictionaryDetail extends StatelessWidget {
  ManualData founddata;

  DictionaryDetail({Key? key, required this.founddata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: fColor,
        title: Text(founddata.title.toString()),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/exercise_img/${founddata.id}.png"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: founddata.description!
                      .map((item) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '$item',
                              style: bodyRegular_16,
                            ),
                          ))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
