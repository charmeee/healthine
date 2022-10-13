import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:healthin/Dictionary/services/dictionary_api.dart';

import 'dictionary_detail_screeen.dart';

//getDicionaryListByEquipmentId

class QrDictionary extends StatefulWidget {
  final String equipmentId;

  const QrDictionary({Key? key, required this.equipmentId}) : super(key: key);

  @override
  State<QrDictionary> createState() => _QrDictionaryState();
}

class _QrDictionaryState extends State<QrDictionary> {
  late List<DictionaryData> dictionaryList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  getList() async {
    try {
      List<DictionaryData> tmp =
          await getDicionaryListByEquipmentId(widget.equipmentId);
      setState(() {
        dictionaryList = tmp;
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("알림"),
                content: Text("기구에 연결된 메뉴얼이 없습니다."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("확인"))
                ],
              ));
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("--기구 운동"),
      ),
      body: ListView.separated(
        itemCount: dictionaryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DictionaryDetail(founddata: dictionaryList[index])));
            },
            title: Text(dictionaryList[index].title.toString()),
            trailing: Text(dictionaryList[index].type.toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
