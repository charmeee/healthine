import 'package:flutter/material.dart';
import 'package:healthin/Diet/models/diet_model.dart';

import '../../Common/Const/const.dart';
import '../../Common/styles/textStyle.dart';

class DietTypeChips extends StatefulWidget {
  const DietTypeChips({Key? key}) : super(key: key);

  @override
  State<DietTypeChips> createState() => _DietTypeChipsState();
}

class _DietTypeChipsState extends State<DietTypeChips> {
  var isSelected = List<bool>.filled(DietType.values.length, false);
  int nowHour = DateTime.now().hour;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (nowHour >= 5 && nowHour < 11) {
      isSelected[0] = true;
    } else if (nowHour >= 11 && nowHour < 14) {
      isSelected[1] = true;
    } else if (nowHour >= 17 && nowHour < 20) {
      isSelected[2] = true;
    } else {
      isSelected[3] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (var i = 0; i < DietType.values.length; i++)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ChoiceChip(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              backgroundColor: Colors.black54,
              selectedColor: primaryColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              label: Text(
                DietType.values[i].korName,
                style: bodyRegular_16.copyWith(
                  color: isSelected[i] ? whiteColor : backgroundColor,
                ),
              ),
              selected: isSelected[i],
              onSelected: (bool selected) {
                if (selected) {
                  setState(() {
                    isSelected =
                        List<bool>.filled(DietType.values.length, false);
                    isSelected[i] = selected;
                  });
                }
              },
            ),
          ),
      ],
    );
  }
}
