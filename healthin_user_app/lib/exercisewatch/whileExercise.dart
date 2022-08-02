import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
//import './youtubePlayer.dart';

const textstyle1 = TextStyle(color: Colors.white);
const double buttonheight = 40;
const double buttonwidth = 150;
int tempsec = -1;

class WhileExercise extends StatefulWidget {
  WhileExercise({
    Key? key,
    required this.exerciseName,
    required this.addDidexercise,
  }) : super(key: key);
  String exerciseName;
  final Function(Map) addDidexercise; //map name,time,number
  @override
  State<WhileExercise> createState() => _WhileExerciseState();
}

//https://stackoverflow.com/questions/63491990/flutter-start-and-stop-stopwatch-from-parent-widget

class _WhileExerciseState extends State<WhileExercise> {
  final stopwatch = Stopwatch();
  bool flag = false;
  String hours = '00';
  String minutes = '00';
  String seconds = '00';
  final duration = const Duration(seconds: 1);
  int exercise_num = 0; //운동횟수
  int standard_sec = 4; //사용자가 정하는 시간
  Map result = {};
  //int getTime = 0; //넘겨줄시간
  void initState() {
    stopwatch.start();
    startTimer();
    flag = true;
    result = {
      "name": widget.exerciseName,
      "time": minutes,
      "number": exercise_num.toString()
    };
  }

  void startTimer() {
    Timer(duration, keepRunning); //Timer(Duration duration, void callback())
  }

  void keepRunning() {
    if (stopwatch.isRunning) {
      startTimer();
    }
    if (tempsec == standard_sec) {
      exercise_num++;
      tempsec = 0;
    }
    setState(() {
      tempsec++;
      minutes = stopwatch.elapsed.inMinutes.toString().padLeft(2, "0");
      seconds = (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void dispose() {
    // TODO: 시간을 상위 state에 넘겨 줘야함.
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: flag ? Colors.green : Colors.red,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                flag ? "${widget.exerciseName}\n운동중" : "휴식중",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
              ),
              Text(
                '$minutes:$seconds',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 60),
              ),
              Text(
                "$exercise_num 회",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
              ),
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: buttonheight,
                      width: buttonwidth,
                      child: TextButton(
                        child: flag
                            ? Text("휴식", style: textstyle1)
                            : Text("다시 시작", style: textstyle1),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                flag ? Colors.red : Colors.green)),
                        onPressed: () {
                          if (flag) {
                            //스탑워치가 실행중일때 멈추면
                            setState(() {
                              stopwatch.stop();
                              flag = false;
                            });
                          } else {
                            setState(() {
                              stopwatch.start();
                              startTimer();
                              flag = true;
                            });
                          }
                          print(stopwatch.isRunning);
                          print(stopwatch.elapsedMilliseconds);
                        },
                      ),
                    ),
                    SizedBox(
                      height: buttonheight,
                      width: buttonwidth,
                      child: TextButton(
                        onPressed: () => {
                          setState(() async {
                            result = await {
                              "name": widget.exerciseName,
                              "time": minutes,
                              "number": exercise_num.toString()
                            };
                            widget.addDidexercise(result);
                            Navigator.of(context).pop();
                          })

                          //Navigator.of(context).popUntil((route) => route.isFirst)
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black54)),
                        child: Text(
                          "운동완료",
                          style: textstyle1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: buttonheight,
                      width: buttonwidth,
                      child: TextButton(
                        onPressed: () => {
                          launchUrl(Uri.parse(
                              "https://www.youtube.com/watch?v=2K2WCGstHOY"))
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black54)),
                        child: Text(
                          "운동 영상 보기",
                          style: textstyle1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
