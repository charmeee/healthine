import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double _percent = 0.7;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.indigo,
        height: 230,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "전민지",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 6,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: QrImage(
                                        padding: EdgeInsets.all(20),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        data: '전민지',
                                      ),
                                    );
                                  });
                            },
                            child: QrImage(
                              padding: EdgeInsets.all(5),
                              data: '전민지',
                              backgroundColor: Colors.white,
                              size: 150,
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: LinearPercentIndicator(
                    barRadius: Radius.circular(4),
                    lineHeight: 14.0,
                    percent: _percent,
                    trailing: Padding(
                      //sufix content
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '${_percent * 100}%',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ), //right content
                    ),
                    backgroundColor: Colors.grey[700],
                    progressColor: Colors.yellow,
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ]),
        ));
  }
}
