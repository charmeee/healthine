import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        tileColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          reference.title,
          style: h3Bold_18,
        ),
        subtitle: Text(
          reference.description,
          maxLines: 1,
          style: bodyRegular_14,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReferenceScreen(referenceId: reference.id)));
          //.then((value) => refreshKey.currentState?.show());
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/icons/thumbup.svg",
              color: Colors.white,
            ),
            Text(
              reference.likesCount.toString(),
              style: bodyRegular_14,
            ),
          ],
        ),
      ),
    );
  }
}
