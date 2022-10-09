import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/dictonary_provider.dart';
import 'package:healthin/Provider/routine_provider.dart';
import '../../Model/routine_models.dart';
import 'dictionary_detail.dart';
import 'package:uuid/uuid.dart';

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
  final List<RoutineData> routineList = [];

  @override
  Widget build(BuildContext context) {
    final routineListRead = ref.read(RoutineNotifierProvider.notifier);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SearchBar(), //검색창
            ChipsWidget(), //칩들
            DictionaryList(
                routineList: routineList,
                addmode: widget.addmode,
                addRoutineData: addRoutineData,
                removeRoutineData: removeRoutineData), //리스트
          ],
        ),
      ),
      bottomNavigationBar: routineList.isNotEmpty
          ? ElevatedButton(
              onPressed: () {
                routineListRead.addRoutineData(routineList); //이걸 변경해야함.
                Navigator.pop(context);
              },
              child: Text("루틴추가하기"))
          : null,
    );
  }

  addRoutineData(RoutineData routinedata) {
    setState(() {
      routineList.add(routinedata);
    });
    log(routinedata.id.toString());
    log(routinedata.name.toString());
  }

  removeRoutineData(String data) {
    setState(() {
      routineList.removeWhere((item) => item.name == data);
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
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      height: 40,
      child: TextField(
        style: TextStyle(fontSize: 15),
        focusNode: focusNode,
        autofocus: false,
        keyboardType: TextInputType.text,
        onChanged: (text) =>
            ref.read(searchBynameProvider.notifier).state = text,
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
    return SizedBox(
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
                    color: isSelected[index] ? Colors.white : Colors.indigo),
                selectedColor: Colors.indigo,
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
  final List<RoutineData> routineList;
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
        child: filteredDatasWatch == null || filteredDatasWatch.isEmpty
            ? Text("로딩중")
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      widget.addmode
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Text("개수추가"),
                                );
                              })
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DictionaryDetail(
                                      founddata: filteredDatasWatch[index])),
                            );
                    },
                    trailing: widget.addmode
                        ? Checkbox(
                            value: widget.routineList.any((item) =>
                                item.name == filteredDatasWatch[index].title),
                            onChanged: (value) {
                              log(widget.routineList.length.toString());
                              log("체크박스 value" + value.toString());
                              if (value!) {
                                widget.addRoutineData(RoutineData(
                                    name: filteredDatasWatch[index].title,
                                    type: filteredDatasWatch[index].type,
                                    numPerSet: 10,
                                    weight: 10,
                                    img:
                                        "assets/exercise_img/${filteredDatasWatch[index].id}.png"));
                              } else {
                                widget.removeRoutineData(
                                    filteredDatasWatch[index].title);
                              }
                            })
                        : null,
                    title: Text(filteredDatasWatch[index].title.toString()),
                  );
                },
                itemCount: filteredDatasWatch.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 10,
                  color: Colors.indigo,
                ),
              ),
      ),
    );
  }
}
