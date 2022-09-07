import 'package:flutter/material.dart';
import 'package:healthin/Model/dictionary_model.dart';
import 'package:healthin/Model/routine_models.dart';

class DictionaryDetail extends StatelessWidget {
  DictionaryData founddata;

  DictionaryDetail({Key? key, required this.founddata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(founddata.name.toString()),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(founddata.name.toString()),
                Text(founddata.enName.toString()),
                Image.asset("assets/img_exercise/${founddata.id}.png")
              ],
            ),
            Column(
                children:
                    founddata.content!.map((item) => Text('- $item')).toList()),
          ],
        ),
      ),
    );
  }
}
