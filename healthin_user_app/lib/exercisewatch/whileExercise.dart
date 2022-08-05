import 'dart:async';
import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../models.dart';
//import './youtubePlayer.dart';

const textstyle1 = TextStyle(color: Colors.white);
const double buttonheight = 40;
//const double buttonwidth = ;
int tempsec = -1;

class WhileExercise extends StatefulWidget {
  const WhileExercise({
    Key? key,
    required this.exerciseName,
    required this.addDidexercise,
  }) : super(key: key);
  final String exerciseName;
  final Function(UserExerciseData) addDidexercise; //map name,time,number
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
  late UserExerciseData exerciseData;
  //late Map exerciseSet;
  //int getTime = 0; //넘겨줄시간
  void initState() {
    stopwatch.start();
    startTimer();
    flag = true;
    exerciseData = UserExerciseData(name: widget.exerciseName, totalnum: 1);
  }

  void startTimer() {
    Timer(duration, keepRunning); //Timer(Duration duration, void callback())
  }

  void keepRunning() {
    if (stopwatch.isRunning) {
      startTimer();
    }
    if (exerciseData.totalnum != 0 &&
        exerciseData.totalnum % exerciseData.numPerSet == 0) {
      //한세트 끝낫을때
      exerciseData.doingSet++;
      setState(() async {
        flag = false;
        stopwatch.stop();
        stopwatch.reset();
        log("스탑워치 멈춤/휴식");
        await Future.delayed(Duration(seconds: exerciseData.restTime), () {
          log("휴식끝 다시시작");
          stopwatch.start();
          startTimer();
          flag = true;
        });
      });
    }
    if (stopwatch.elapsed.inSeconds % exerciseData.countInterver == 0) {
      exerciseData.totalnum++;
      log("개수증가");
    }
    setState(() {
      minutes = stopwatch.elapsed.inMinutes.toString().padLeft(2, "0");
      seconds = (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
      //log("stringsec" + seconds);
      //log(stopwatch.elapsed.inSeconds.toString());
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
                //이름
                exerciseData.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
              ),
              Text(
                //시간
                '$minutes:$seconds',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 60),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //현 개수 / 총 개수
                    "${exerciseData.totalnum % exerciseData.numPerSet} / ${exerciseData.numPerSet} 개",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                  ),
                  _BodyButtons(
                      onPressedPlus: pressedPlus(),
                      onPressedMinus: pressedMinus())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //현세트 / 총세트
                    "${exerciseData.doingSet} / ${exerciseData.totalSet} 세트",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                  ),
                  _BodyButtons(
                      onPressedPlus: pressedPlus(),
                      onPressedMinus: pressedMinus())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //개수 사이 시간
                    "${exerciseData.countInterver} 속도",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                  ),
                  _BodyButtons(
                      onPressedPlus: pressedPlus(),
                      onPressedMinus: pressedMinus())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //쉬는시간
                    "${exerciseData.restTime} 휴식",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                  ),
                  _BodyButtons(
                      onPressedPlus: pressedPlus(),
                      onPressedMinus: pressedMinus())
                ],
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      // height: buttonheight,
                      width: MediaQuery.of(context).size.width / 3 * 0.8,
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
                      // height: buttonheight,
                      width: MediaQuery.of(context).size.width / 3 * 0.8,
                      child: TextButton(
                        onPressed: () => {
                          setState(() async {
                            exerciseData.totalTime =
                                stopwatch.elapsed.inSeconds;
                            widget.addDidexercise(exerciseData);
                            Navigator.of(context).pop();
                          })

                          //Navigator.of(context).popUntil((route) => route.isFirst)
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black54)),
                        child: Text(
                          "운동 완료",
                          style: textstyle1,
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: buttonheight,
                      width: MediaQuery.of(context).size.width / 3 * 0.8,
                      child: TextButton(
                        onPressed: () => {
                          launchUrl(Uri.parse(
                              "https://www.youtube.com/watch?v=2K2WCGstHOY"))
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black54)),
                        child: Text(
                          "운동 방법",
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

  pressedPlus() {
    String daf = "name";
  }

  pressedMinus() {}
}

class _BodyButtons extends StatelessWidget {
  _BodyButtons(
      {Key? key, required this.onPressedPlus, required this.onPressedMinus})
      : super(key: key);
  final Function onPressedPlus;
  final Function onPressedMinus;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              onPressedMinus;
            },
            icon: Icon(Icons.exposure_minus_1)),
        IconButton(
            onPressed: () {
              onPressedPlus;
            },
            icon: Icon(Icons.plus_one))
      ],
    );
  }
}
