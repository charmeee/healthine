import 'package:flutter/material.dart';
import 'package:healthin/Common/styles/buttonStyle.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/Routine/screens/routineSetting_screen.dart';
import 'package:healthin/Routine/services/referenceRoutine_api.dart';

import '../widgets/routineName_dialog.dart';

class ReferenceScreen extends StatefulWidget {
  final String referenceId;
  const ReferenceScreen({Key? key, required this.referenceId})
      : super(key: key);

  @override
  State<ReferenceScreen> createState() => _ReferenceScreenState();
}

class _ReferenceScreenState extends State<ReferenceScreen> {
  ReferenceRoutine referenceRoutine = ReferenceRoutine.init();
  final _routineFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    ///routines/{routineId}
    // TODO: implement initState
    super.initState();
    getReferenceRoutineDetail();
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                referenceRoutine.title,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                referenceRoutine.description,
                style: TextStyle(color: Colors.white),
                maxLines: 5,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: referenceRoutine.routineManuals!
                .map((e) => ListTile(
                      title: Text(e.manualTitle,
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                          "${e.weight}kg/ ${e.targetNumber}회/ ${e.setNumber}세트",
                          style: TextStyle(color: Colors.white)),
                    ))
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Form(
                      key: _routineFormKey,
                      child: NameInputDialog(
                        routineFormKey: _routineFormKey,
                        hasReference: true,
                      ),
                    );
                  }).then((value) {
                if (value != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoutineSetting(
                                routineTitle: value.toString(),
                                routine: MyRoutine.fromReferenceRoutine(
                                    referenceRoutine, value.toString()),
                                isNew: true,
                              )));
                }
              });
            },
            child: Text("루틴 가져오기"),
            style: primaryButton,
          )
        ],
      ),
    );
  }
}
