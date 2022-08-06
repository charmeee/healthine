import 'package:flutter/material.dart';

import 'inbodychart.dart';

class InbodyCard extends StatelessWidget {
  const InbodyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //여기까지 바깥으로빼고 안에 인수로다가 List<Widget>을넘겨줘서 바깥으로 빼면될듯.
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "인바디기록",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          InbodyChart(),
        ],
      ),
    ));
  }
}
