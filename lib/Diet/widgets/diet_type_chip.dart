import 'package:flutter/material.dart';
import 'package:healthin/Diet/models/diet_model.dart';

import '../../Common/Const/const.dart';
import '../../Common/styles/textStyle.dart';

class DietTypeChips extends StatefulWidget {
  final Function(DietType dietType) setDietType;
  final DietType nowDietType;
  const DietTypeChips(
      {Key? key, required this.setDietType, required this.nowDietType})
      : super(key: key);

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
    if (widget.nowDietType == DietType.breakfast) {
      isSelected[0] = true;
    } else if (widget.nowDietType == DietType.lunch) {
      isSelected[1] = true;
    } else if (widget.nowDietType == DietType.dinner) {
      isSelected[2] = true;
    } else if (widget.nowDietType == DietType.snack) {
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
                    switch (i) {
                      case 0:
                        widget.setDietType(DietType.breakfast);
                        break;
                      case 1:
                        widget.setDietType(DietType.lunch);
                        break;
                      case 2:
                        widget.setDietType(DietType.dinner);
                        break;
                      case 3:
                        widget.setDietType(DietType.snack);
                        break;
                    }
                  });
                }
              },
            ),
          ),
      ],
    );
  }
}
