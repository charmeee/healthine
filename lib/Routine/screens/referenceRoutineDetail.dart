import 'package:flutter/material.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/Routine/services/referenceRoutine_api.dart';

class ReferenceScreen extends StatefulWidget {
  final String referenceId;
  const ReferenceScreen({Key? key, required this.referenceId})
      : super(key: key);

  @override
  State<ReferenceScreen> createState() => _ReferenceScreenState();
}

class _ReferenceScreenState extends State<ReferenceScreen> {
  ReferenceRoutine referenceRoutine = ReferenceRoutine.init();
  @override
  void initState() {
    ///routines/{routineId}
    // TODO: implement initState
    super.initState();
  }

  getReferenceRoutineDetail() async {
    final response = await getReferenceRoutine(widget.referenceId);
    setState(() {
      referenceRoutine = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(referenceRoutine.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(referenceRoutine.title),
                Text(referenceRoutine.description),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: referenceRoutine.routineManuals!
                  .map((e) => ListTile(
                        title: Text(e.manualTitle),
                        subtitle: Text(
                            "${e.weight}kg/ ${e.targetNumber}회/ ${e.setNumber}세트"),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
