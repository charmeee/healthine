import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../models.dart';

final List<String> healthtype = [
  "가슴",
  "등",
  "어깨",
  "팔",
  "복근",
  "하체",
  "유산소",
];

class Dictionary extends StatefulWidget {
  Dictionary({Key? key}) : super(key: key);

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  var isSelected = List<bool>.filled(healthtype.length, false);
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  List<Exercise>? alldata = []; //json 파일받아온값
  List<Exercise>? founddata = []; //찾은데이터=> 출력데이터
  List<Exercise>? nonchipselecteddata = []; //칩 셀랙전 데이터

  Future<void> readJson() async {
    //json파일 읽어오기
    final String response =
        await rootBundle.loadString('testjsonfile/healthmachinedata.json');
    //print(response.runtimeType);w
    Map<String, dynamic> _alldata = await jsonDecode(response);
    setState(() {
      alldata = [
        ..._alldata["exerciseType"].map((item) => Exercise.fromJson(item))
      ];
      founddata = [...alldata!];
    });
  }

  void initState() {
    super.initState();
    readJson();
  }

  void runSearchFilter(String enteredKeyword) {
    List<Exercise>? result = [];
    if (enteredKeyword.isEmpty) {
      result = [...alldata!];
    } else {
      result = alldata!
          .where((data) =>
              data.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      founddata = result;
    });
  }

  void runChipFilter() {
    List<Exercise>? result = [];
    bool flag = true;
    for (int i = 0; i < healthtype.length; i++) {
      if (isSelected[i] == true) {
        flag = false;
        result = alldata!
            .where((data) => data.type!.contains(healthtype[i]))
            .toList();
      }
    }
    if (flag) {
      result = [...alldata!];
    }
    setState(() {
      founddata = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            height: 40,
            child: TextField(
              style: TextStyle(fontSize: 15),
              focusNode: focusNode,
              autofocus: false,
              keyboardType: TextInputType.text,
              onChanged: (text) => runSearchFilter(text),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                hintText: "운동을 검색해주세요",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.indigo),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.indigo),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          //검색창
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: healthtype.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(0, 3, 10, 3),
                    child: ChoiceChip(
                      backgroundColor: Colors.indigo[50],
                      label: Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 30,
                          child: Text(healthtype[index])),
                      selected: isSelected[index],
                      onSelected: (bool value) {
                        setState(() {
                          isSelected =
                              List<bool>.filled(healthtype.length, false);
                          isSelected[index] = value;
                          runChipFilter();
                        });
                      },
                      labelStyle: TextStyle(
                          color:
                              isSelected[index] ? Colors.white : Colors.indigo),
                      selectedColor: Colors.indigo,
                    ),
                  );
                }),
          ),
          //chips
          Expanded(
            child: Container(
              child: alldata == null || alldata!.isEmpty
                  ? Text("로딩중")
                  : ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(founddata![index]
                                                  .name
                                                  .toString()),
                                              Text(founddata![index]
                                                  .enName
                                                  .toString()),
                                              Image.asset(
                                                  "assets/img_exercise/${founddata![index].id}.png")
                                            ],
                                          ),
                                          Column(
                                              children: founddata![index]
                                                  .content!
                                                  .map(
                                                      (item) => Text('- $item'))
                                                  .toList()),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          title: Text(founddata![index].name.toString()),
                        );
                      },
                      itemCount: founddata!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 10,
                        color: Colors.indigo,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
