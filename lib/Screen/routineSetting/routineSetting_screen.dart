import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/routine_provider.dart';

class RoutineSetting extends ConsumerWidget {
  const RoutineSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineListWatch = ref.watch(RoutineNotifierProvider);
    final _routineList = routineListWatch;
    final routineListRead = ref.read(RoutineNotifierProvider.notifier);
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
              itemCount: routineListWatch.length,
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
                      '${routineListWatch[index].name}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {},
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                //깊은 복사가 안되었어서 생긴문제 ㅎ;
                final _routineList = [...routineListWatch];
                var item = _routineList.removeAt(oldIndex);
                _routineList.insert(newIndex, item);
                routineListRead.changeRoutineOrder(_routineList);
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

// class RoutineSetting extends StatefulWidget {
//   RoutineSetting({Key? key}) : super(key: key);
//   @override
//   State<RoutineSetting> createState() => _RoutineSettingState();
// }

// class _RoutineSettingState extends State<RoutineSetting> {
//   List _routineList = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _routineList = [...widget.routineList];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: Icon(Icons.backspace),
//         ),
//         title: Text("루틴 수정하기"),
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
//         backgroundColor: Colors.indigo,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ReorderableListView.builder(
//               padding: EdgeInsets.all(8),
//               itemCount: _routineList.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   //key: ValueKey(_routineList["type"]), 는 이름에따라서 키가 발급됨 만약 이름이 같으면 같은키
//                   key: Key('$index'),
//                   color: Colors.indigo[50],
//                   elevation: 1,
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(10),
//                     title: Text(
//                       '${_routineList[index]["type"]}',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     onTap: () {},
//                   ),
//                 );
//               },
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   if (oldIndex < newIndex) {
//                     newIndex -= 1;
//                   }
//                   var item = _routineList.removeAt(oldIndex);
//                   _routineList.insert(newIndex, item);
//                   widget.changeRoutine(_routineList);
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: Text("추천 운동 루틴"),
//                     ),
//                     style: ElevatedButton.styleFrom(primary: Colors.indigo),
//                   ),
//                 )),
//                 Expanded(
//                     child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: Text("부위별 운동 루틴"),
//                     ),
//                     style: ElevatedButton.styleFrom(primary: Colors.black54),
//                   ),
//                 ))
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
