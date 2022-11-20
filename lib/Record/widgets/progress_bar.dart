import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthin/Common/Const/const.dart';

//모두 순서가 0 부터 시작
class StepProgressView extends StatelessWidget {
  final int maxStep;
  final int curStep;
  final Color activeColor = primaryColor;
  final Color inactiveColor = darkGrayColor;
  final double lineWidth = 3.0;

  const StepProgressView({
    Key? key,
    required this.maxStep,
    required this.curStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _iconViews(),
    );
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    for (int i = 0; i < maxStep; i++) {
      var circleColor =
          (i == 0 || curStep + 1 > i) ? activeColor : inactiveColor;
      var lineColor = curStep > i ? activeColor : inactiveColor;
      var iconColor = (i == 0 || curStep > i + 1) ? activeColor : inactiveColor;
      list.add(
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            /* color: circleColor,*/
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
            border: Border.all(
              color: circleColor,
              width: 2.0,
            ),
          ),
          child: Icon(
            Icons.circle,
            color: iconColor,
            size: 12.0,
          ),
        ),
      );

      //line between icons
      if (i != maxStep - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    }

    return list;
  }
}
