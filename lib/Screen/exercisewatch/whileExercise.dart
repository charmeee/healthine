import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../../Model/models.dart';
import '../../Provider//exercisedata_provider.dart';
//import './youtubePlayer.dart';

const textstyle1 = TextStyle(color: Colors.white);
const double buttonheight = 40;
int tempsec = -1;

class WhileExercise extends ConsumerStatefulWidget {
  const WhileExercise({
    Key? key,
    required this.exerciseName,
  }) : super(key: key);
  final exerciseName;
  @override
  ConsumerState<WhileExercise> createState() => _WhileExerciseState();
}

//휴식 운동중 정지로구분트
class _WhileExerciseState extends ConsumerState<WhileExercise> {
  //final stopwatch = Stopwatch();
  bool flag = false;
  String hours = '00';
  String minutes = '00';
  String seconds = '00';
  final duration = const Duration(seconds: 1);
  late UserExerciseData exerciseData;
  //late Map exerciseSet;
  //int getTime = 0; //넘겨줄시간
  Timer? _timer;
  var _time = 0;

  void initState() {
    startTimer();
    flag = true;
    exerciseData = UserExerciseData(name: widget.exerciseName, totalnum: 1);
  }

  void startTimer() {
    _timer = Timer.periodic(duration, (timer) async {
      _time++;
      if (_time % exerciseData.countInterver == 0 && flag) {
        exerciseData.totalnum++;
        log("개수증가");
      }
      setState(() {
        minutes = (_time / 60).toInt().toString().padLeft(2, "0");
        seconds = (_time % 60).toString().padLeft(2, "0");
        //log("stringsec" + seconds);
        //log(stopwatch.elapsed.inSeconds.toString());
      });
      if (exerciseData.totalnum ==
              exerciseData.numPerSet * exerciseData.doingSet + 1 &&
          flag == true) {
        //한세트 끝낫을때
        log("세트증가");
        exerciseData.doingSet++;
        setState(() {
          flag = false;
        });
        _timer?.cancel();
        log("스탑워치 멈춤/휴식");
        await Future.delayed(Duration(seconds: exerciseData.restTime), () {
          log("스탑워치 다시시작!");
          flag = true;
          startTimer();
        });
      }
    }); //Timer(Duration duration, void callback())
  }

  void dispose() {
    // TODO: 시간을 상위 state에 넘겨 줘야함.

    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final UserExercisedRead =
        ref.read(UserExercisedNotifierProvider.notifier); //함수들
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
                    "${(exerciseData.totalnum - 1) % exerciseData.numPerSet + 1} / ${exerciseData.numPerSet} 개",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.numPerSet--;
                            });
                          },
                          icon: Icon(Icons.exposure_minus_1)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.numPerSet++;
                            });
                          },
                          icon: Icon(Icons.plus_one))
                    ],
                  )
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
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.totalSet--;
                            });
                          },
                          icon: Icon(Icons.exposure_minus_1)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.totalSet++;
                            });
                          },
                          icon: Icon(Icons.plus_one))
                    ],
                  )
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
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.countInterver--;
                            });
                          },
                          icon: Icon(Icons.exposure_minus_1)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.countInterver++;
                            });
                          },
                          icon: Icon(Icons.plus_one))
                    ],
                  )
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
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.restTime--;
                            });
                          },
                          icon: Icon(Icons.exposure_minus_1)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              exerciseData.restTime++;
                            });
                          },
                          icon: Icon(Icons.plus_one))
                    ],
                  )
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
                              _timer?.cancel();
                              flag = false;
                            });
                          } else {
                            setState(() {
                              startTimer();
                              flag = true;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      // height: buttonheight,
                      width: MediaQuery.of(context).size.width / 3 * 0.8,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            exerciseData.totalTime = _time;
                            UserExercisedRead.add(exerciseData);
                            _timer?.cancel();
                          });
                          Future.delayed(
                              Duration(
                                milliseconds: 10,
                              ), () {
                            Navigator.of(context).pop();
                          });
                        },
                        //Navigator.of(context).popUntil((route) => route.isFirst)
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
}
