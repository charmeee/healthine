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
    return Container();
  }
}
