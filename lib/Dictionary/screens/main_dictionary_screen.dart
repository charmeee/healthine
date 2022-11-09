import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Dictionary/providers/dictonary_provider.dart';
import 'package:healthin/Routine/providers/routine_provider.dart';
import '../../Routine/models/routine_models.dart';
import 'package:uuid/uuid.dart';

import 'dictionary_detail_screeen.dart';

var uuid = const Uuid();
final List<String> healthtype = [
  "가슴",
  "등",
  "어깨",
  "팔",
  "복근",
  "하체",
  "유산소",
];

//view, add, edit mode 총 3가지.

class Dictionary extends ConsumerStatefulWidget {
  const Dictionary({Key? key, required this.addmode}) : super(key: key);
  final bool addmode;
  @override
  ConsumerState<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends ConsumerState<Dictionary> {
  final List<RoutineManual> routineList = [];

  @override
  Widget build(BuildContext context) {
    final routineListRead = ref.read(userRoutinePreviewProvider.notifier);
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 64,
            alignment: Alignment.centerLeft,
            child: Text(
              "운동사전",
              style: h1Bold_24,
            ),
          ),
          SearchBar(), //검색창
          SizedBox(
            height: 8,
          ),
          ChipsWidget(), //칩들
          DictionaryList(
              routineList: routineList,
              addmode: widget.addmode,
              addRoutineData: addRoutineData,
              removeRoutineData: removeRoutineData), //리스트
        ],
      ),
      bottomNavigationBar: routineList.isNotEmpty
          ? ElevatedButton(
              onPressed: () {
                Navigator.pop(context, routineList);
              },
              child: Text("루틴추가하기"))
          : null,
    );
  }

  addRoutineData(RoutineManual routinedata) {
    log("addRoutineData");

    setState(() {
      routineList.add(routinedata);
    });
  }

  removeRoutineData(String dataId) {
    log("removeRoutineData");
    setState(() {
      routineList.removeWhere((item) => item.manualId == dataId);
    });
  }
}

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends ConsumerState<SearchBar> {
  @override
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // "ref"는 build 메소드 안에서 프로바이더를 구독(listen)하기위해 사용할 수 있습니다.
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      decoration: BoxDecoration(
        color: darkGrayColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: bodyRegular_14,
        focusNode: focusNode,
        autofocus: false,
        keyboardType: TextInputType.text,
        onChanged: (text) =>
            ref.read(searchBynameProvider.notifier).state = text,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          icon: Icon(Icons.search),
          hintText: "운동을 검색해주세요",
          border: InputBorder.none,
          hoverColor: Colors.white,
        ),
      ),
    );
  }
}

class ChipsWidget extends ConsumerStatefulWidget {
  const ChipsWidget({Key? key}) : super(key: key);

  @override
  ChipsWidgetState createState() => ChipsWidgetState();
}

class ChipsWidgetState extends ConsumerState<ChipsWidget> {
  var isSelected = List<bool>.filled(healthtype.length, false);

  @override
  Widget build(BuildContext context) {
    // "ref"는 build 메소드 안에서 프로바이더를 구독(listen)하기위해 사용할 수 있습니다.
    return Container(
      height: 32,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.only(left: 16),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: healthtype.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              height: 32,
              child: ChoiceChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                backgroundColor: darkGrayColor,
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                label: Text(healthtype[index]),
                selected: isSelected[index],
                onSelected: (bool value) {
                  setState(() {
                    isSelected = List<bool>.filled(healthtype.length, false);
                    isSelected[index] = value;
                    //value가 참이면 filter 값에 대입해서  chipfilter를 실행시킨다.
                    if (value) {
                      ref.read(searchBytypeProvider.notifier).state =
                          healthtype[index];
                    } else {
                      ref.read(searchBytypeProvider.notifier).state = null;
                    }
                  });
                },
                labelStyle: TextStyle(
                    color: isSelected[index] ? lightGrayColor : whiteColor),
                selectedColor: primaryColor,
                elevation: 0,
              ),
            );
          }),
    );
  }
}

class DictionaryList extends ConsumerStatefulWidget {
  const DictionaryList(
      {Key? key,
      required this.addmode,
      required this.routineList,
      required this.addRoutineData,
      required this.removeRoutineData})
      : super(key: key);
  final bool addmode;
  final List<RoutineManual> routineList;
  final Function addRoutineData;
  final Function removeRoutineData;

  @override
  DictionaryListState createState() => DictionaryListState();
}

class DictionaryListState extends ConsumerState<DictionaryList> {
  @override
  Widget build(BuildContext context) {
    // "ref"는 build 메소드 안에서 프로바이더를 구독(listen)하기위해 사용할 수 있습니다.
    final filteredDatasWatch = ref.watch(filteredDictionaryDatas);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: filteredDatasWatch == null || filteredDatasWatch.isEmpty
            ? Text("로딩중")
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DictionaryDetail(
                                founddata: filteredDatasWatch[index])),
                      );
                    },
                    trailing: widget.addmode
                        ? Checkbox(
                            value: widget.routineList.any((item) =>
                                item.manualId == filteredDatasWatch[index].id),
                            onChanged: (value) {
                              log(widget.routineList.length.toString());
                              log("체크박스 value" + value.toString());
                              if (value!) {
                                RoutineManual routineManual =
                                    RoutineManual.init();
                                routineManual.manualId =
                                    filteredDatasWatch[index].id;
                                routineManual.manualTitle =
                                    filteredDatasWatch[index].title;
                                widget.addRoutineData(routineManual);
                              } else {
                                widget.removeRoutineData(
                                    filteredDatasWatch[index].id);
                              }
                            })
                        : null,
                    title: Text(
                      filteredDatasWatch[index].title.toString(),
                      style: bodyRegular_16,
                    ),
                  );
                },
                itemCount: filteredDatasWatch.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 10,
                  color: mediumGrayColor,
                ),
              ),
      ),
    );
  }
}
