// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:healthin/Routine/providers/routine_provider.dart';
//
// class RoutineAdding extends ConsumerWidget {
//   RoutineAdding({Key? key, required this.index}) : super(key: key);
//   int index;
//   List<String> props = ["time", "weight", "set", "num"];
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final routineListWatch = ref.watch(RoutineNotifierProvider);
//     return Dialog(
//       child: Container(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: routineListWatch[index].type == "유산소"
//               ? [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                     child: Text(
//                       routineListWatch[index].name.toString(),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   AddRowButton(
//                     index: index,
//                     props: props[0],
//                   )
//                 ]
//               : [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                     child: Text(
//                       routineListWatch[index].name.toString(),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   for (var i = 1; i < props.length; i++)
//                     AddRowButton(
//                       index: index,
//                       props: props[i],
//                     ),
//                 ],
//         ),
//       ),
//     );
//   }
// }
//
// class AddRowButton extends ConsumerWidget {
//   AddRowButton({Key? key, required this.index, required this.props})
//       : super(key: key);
//   int index;
//   String props;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final routineListWatch = ref.watch(RoutineNotifierProvider);
//     final routineListRead = ref.read(RoutineNotifierProvider.notifier);
//     String content = "";
//     switch (props) {
//       case "time":
//         content = "${routineListWatch[index].totalTime} 분";
//         break;
//       case "weight":
//         content = "${routineListWatch[index].weight} kg";
//         break;
//       case "set":
//         content = "${routineListWatch[index].totalSet} 세트";
//         break;
//       case "num":
//         content = "${routineListWatch[index].numPerSet} 회";
//     }
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         TextButton(
//             onPressed: () {
//               routineListRead.editRoutineDataByIndex(
//                   index: index, props: props, value: -5);
//             },
//             child: Text(
//               '-5',
//               style: TextStyle(color: Colors.indigo),
//             )),
//         TextButton(
//             onPressed: () {
//               routineListRead.editRoutineDataByIndex(
//                   index: index, props: props, value: -1);
//             },
//             child: Text('-1', style: TextStyle(color: Colors.indigo))),
//         Text(
//           content,
//         ),
//         TextButton(
//             onPressed: () {
//               routineListRead.editRoutineDataByIndex(
//                   index: index, props: props, value: 1);
//             },
//             child: Text('+1', style: TextStyle(color: Colors.indigo))),
//         TextButton(
//             onPressed: () {
//               routineListRead.editRoutineDataByIndex(
//                   index: index, props: props, value: 5);
//             },
//             child: Text('+5', style: TextStyle(color: Colors.indigo))),
//       ],
//     );
//   }
// }
