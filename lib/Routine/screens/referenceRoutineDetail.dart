import 'package:flutter/material.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Common/styles/buttonStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
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
        backgroundColor: backgroundColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: darkGrayColor,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              referenceRoutine.description,
              style: bodyRegular_16,
              maxLines: 5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "세부 루틴",
            style: h3Bold_18,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: borderContainer,
              child: ListView.builder(
                itemCount: referenceRoutine.routineManuals!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        referenceRoutine.routineManuals![index].manualTitle,
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                        "${referenceRoutine.routineManuals![index].weight}kg/ ${referenceRoutine.routineManuals![index].targetNumber}회/ ${referenceRoutine.routineManuals![index].setNumber}세트",
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ),

          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: referenceRoutine.routineManuals!
          //       .map((e) => ListTile(
          //             title: Text(e.manualTitle,
          //                 style: TextStyle(color: Colors.white)),
          //             subtitle: Text(
          //                 "${e.weight}kg/ ${e.targetNumber}회/ ${e.setNumber}세트",
          //                 style: TextStyle(color: Colors.white)),
          //           ))
          //       .toList(),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ElevatedButton(
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
            ),
          )
        ],
      ),
    );
  }
}
