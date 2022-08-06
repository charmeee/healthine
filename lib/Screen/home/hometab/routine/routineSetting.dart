import 'package:flutter/material.dart';

class RoutineSetting extends StatefulWidget {
  RoutineSetting(
      {Key? key, required this.changeRoutine, required this.routineList})
      : super(key: key);
  void Function(List Routine) changeRoutine;
  List routineList;
  @override
  State<RoutineSetting> createState() => _RoutineSettingState();
}

class _RoutineSettingState extends State<RoutineSetting> {
  List _routineList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _routineList = [...widget.routineList];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.backspace),
        ),
        title: Text("루틴 수정하기"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _routineList.length,
              itemBuilder: (context, index) {
                return Card(
                  //key: ValueKey(_routineList["type"]), 는 이름에따라서 키가 발급됨 만약 이름이 같으면 같은키
                  key: Key('$index'),
                  color: Colors.indigo[50],
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      '${_routineList[index]["type"]}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {},
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var item = _routineList.removeAt(oldIndex);
                  _routineList.insert(newIndex, item);
                  widget.changeRoutine(_routineList);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text("추천 운동 루틴"),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.indigo),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text("부위별 운동 루틴"),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.black54),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
