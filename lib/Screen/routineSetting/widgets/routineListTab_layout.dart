import 'package:flutter/material.dart';

class RoutineListTabLayout extends StatefulWidget {
  const RoutineListTabLayout({Key? key}) : super(key: key);

  @override
  State<RoutineListTabLayout> createState() => _RoutineListTabLayoutState();
}

class _RoutineListTabLayoutState extends State<RoutineListTabLayout> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      children: List.generate(100, (index) {
        return GestureDetector(
          onTap: () {
            print('tapped');
          },
          child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "내 루틴1",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text("#하체  #어깨")
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "요일: 월,화",
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }
}
