import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/Routine/screens/referenceRoutineDetail.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/routine_models.dart';

class ReferenceRoutineListTile extends StatelessWidget {
  final ReferenceRoutine reference;
  final GlobalKey<RefreshIndicatorState> refreshKey;

  const ReferenceRoutineListTile(
      {Key? key, required this.reference, required this.refreshKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reference.title),
      subtitle: Text(reference.description),
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReferenceScreen(referenceId: reference.id)))
            .then((value) => refreshKey.currentState?.show());
      },
      trailing: Text(reference.likesCount.toString()),
    );
  }
}
