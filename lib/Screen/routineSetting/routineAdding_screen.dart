import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Provider/routine_provider.dart';

class RoutineAdding extends ConsumerWidget {
  RoutineAdding({Key? key, required this.index}) : super(key: key);
  int index;
  List<String> props = ["time", "weight", "set", "num"];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineListWatch = ref.watch(RoutineNotifierProvider);
    return Dialog(
      child: Container(
        height: 300,
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: routineListWatch[index].type == "유산소"
              ? [
                  AddRowButton(
                    index: index,
                    props: props[0],
                  )
                ]
              : [
                  for (var i = 1; i < props.length; i++)
                    AddRowButton(
                      index: index,
                      props: props[i],
                    ),
                ],
        ),
      ),
    );
  }
}

class AddRowButton extends ConsumerWidget {
  AddRowButton({Key? key, required this.index, required this.props})
      : super(key: key);
  int index;
  String props;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineListWatch = ref.watch(RoutineNotifierProvider);
    final routineListRead = ref.read(RoutineNotifierProvider.notifier);
    String content = "";
    switch (props) {
      case "time":
        content = "${routineListWatch[index].time} 분";
        break;
      case "weight":
        content = "${routineListWatch[index].weight} kg";
        break;
      case "set":
        content = "${routineListWatch[index].set} 세트";
        break;
      case "num":
        content = "${routineListWatch[index].num} 회";
    }
    return Row(
      children: [
        TextButton(
            onPressed: () {
              routineListRead.editRoutineData(
                  index: index, props: props, value: -5);
            },
            child: Text('-5')),
        TextButton(
            onPressed: () {
              routineListRead.editRoutineData(
                  index: index, props: props, value: -1);
            },
            child: Text('-1')),
        Text(content),
        TextButton(
            onPressed: () {
              routineListRead.editRoutineData(
                  index: index, props: props, value: 1);
            },
            child: Text('+1')),
        TextButton(
            onPressed: () {
              routineListRead.editRoutineData(
                  index: index, props: props, value: 5);
            },
            child: Text('+5')),
      ],
    );
  }
}
