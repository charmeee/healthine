import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/exerciserecord_model.dart';
import 'package:healthin/Provider/routine_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../../Model/routine_models.dart';
import '../../Provider/exercisedata_provider.dart';
//import './youtubePlayer.dart';

const textstyle1 = TextStyle(color: Colors.white);
const double buttonheight = 40;
int tempsec = -1;

class WhileExercise extends ConsumerStatefulWidget {
  const WhileExercise({
    Key? key,
    required this.routinedata,
    required this.index,
  }) : super(key: key);
  final RoutineData routinedata;
  final int index;
  //RoutineData
  @override
  ConsumerState<WhileExercise> createState() => _WhileExerciseState();
}

//휴식 운동중 정지로구분트
class _WhileExerciseState extends ConsumerState<WhileExercise> {
  //final stopwatch = Stopwatch();
  bool timewatchflag = false;
  bool isAEROBIC = false; //유산소인가
  String hours = '00';
  String minutes = '00';
  String seconds = '00';
  final duration = const Duration(seconds: 1);
  late UserExerciseData exerciseData;
  //late Map exerciseSet;
  //int getTime = 0; //넘겨줄시간
  Timer? _timer;
  var _time = 0;
  late int findedindex;
  @override
  void initState() {
    super.initState();
    findedindex = ref.read(UserExercisedNotifierProvider).indexWhere((element) {
      log("그래도찾음" + element.doingTime.toString());
      return element.name == widget.routinedata.name;
    });
    if (findedindex == -1) {
      exerciseData = UserExerciseData(routineData: widget.routinedata);
    } else {
      exerciseData = ref.read(UserExercisedNotifierProvider)[findedindex];
    }
    _time = exerciseData.doingTime;
    startTimer();
    timewatchflag = true;
    if (widget.routinedata.type == "유산소") {
      isAEROBIC = true;
    }
    // if (widget.routinedata.doing == false) {
    //   ref.read(RoutineNotifierProvider.notifier).doRoutine(widget.index);
    // }
  }

  void startTimer() {
    _timer = Timer.periodic(duration, (timer) async {
      _time++;
      if (isAEROBIC == false) {
        //유산소가 아니면
        if (_time % exerciseData.countInterver == 0 && timewatchflag) {
          exerciseData.doingNum = exerciseData.doingNum + 1;
          log("개수증가");
        }
        if (exerciseData.doingNum ==
                exerciseData.numPerSet * exerciseData.doingSet + 1 &&
            timewatchflag == true) {
          //유산소의 경우 개수 기준으로 카운트해서 멈춤
          //한세트 끝낫을때
          log("세트증가");
          exerciseData.doingSet = exerciseData.doingSet + 1;
          setState(() {
            timewatchflag = false;
          });
          _timer?.cancel();
          log("스탑워치 멈춤/휴식");
          await Future.delayed(Duration(seconds: exerciseData.restTime), () {
            log("스탑워치 다시시작!");
            timewatchflag = true;
            startTimer();
          });
        }
      } else {
        //유산소이면
        if (_time == exerciseData.totalTime) {
          log("유산소 완료");
          setState(() {
            timewatchflag = false;
          });
          _timer?.cancel();
        }
      }
      setState(() {
        minutes = (_time ~/ 60).toString().padLeft(2, "0");
        seconds = (_time % 60).toString().padLeft(2, "0");
        //log("stringsec" + seconds);
        //log(stopwatch.elapsed.inSeconds.toString());
      });
    }); //Timer(Duration duration, void callback())
  }

  @override
  void dispose() {
    // TODO: 시간을 상위 state에 넘겨 줘야함.

    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final userExercisedRead =
        ref.read(UserExercisedNotifierProvider.notifier); //함수들
    return Scaffold(
      body: Container(
        color: timewatchflag ? Colors.green : Colors.red,
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
              if (isAEROBIC == false) ...[
                Row(
                  //현 개수 / 총 개수
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${exerciseData.doingNum != 0 ? (exerciseData.doingNum - 1) % (exerciseData.numPerSet) + 1 : 0} / ${exerciseData.numPerSet} 개",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (exerciseData.numPerSet != 0) {
                                  exerciseData.numPerSet--;
                                }
                              });
                            },
                            icon: Icon(Icons.exposure_minus_1)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (exerciseData.numPerSet != 0) {
                                  exerciseData.numPerSet++;
                                }
                              });
                            },
                            icon: Icon(Icons.plus_one))
                      ],
                    )
                  ],
                ),
                Row(
                  //현세트 / 총세트
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${exerciseData.doingSet} / ${exerciseData.totalSet} 세트",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (exerciseData.totalSet != 0) {
                                  exerciseData.totalSet--;
                                }
                              });
                            },
                            icon: Icon(Icons.exposure_minus_1)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (exerciseData.totalSet != 0) {
                                  exerciseData.totalSet++;
                                }
                              });
                            },
                            icon: Icon(Icons.plus_one))
                      ],
                    )
                  ],
                ),
                Row(
                  //개수 사이 시간
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${exerciseData.countInterver} 속도",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
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
                  //쉬는시간
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${exerciseData.restTime} 휴식",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
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
              ],
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      // height: buttonheight,
                      width: MediaQuery.of(context).size.width / 3 * 0.8,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                timewatchflag ? Colors.red : Colors.green)),
                        onPressed: () {
                          if (timewatchflag) {
                            //스탑워치가 실행중일때 멈추면
                            setState(() {
                              _timer?.cancel();
                              timewatchflag = false;
                            });
                          } else {
                            setState(() {
                              startTimer();
                              timewatchflag = true;
                            });
                          }
                        },
                        child: timewatchflag
                            ? Text("휴식", style: textstyle1)
                            : Text("다시 시작", style: textstyle1),
                      ),
                    ),
                    SizedBox(
                      // height: buttonheight,
                      width: MediaQuery.of(context).size.width / 3 * 0.8,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            exerciseData.doingTime = _time;
                            if (findedindex == -1) {
                              userExercisedRead.add(exerciseData);
                            } else {
                              userExercisedRead.replace(
                                  exerciseData, findedindex);
                            }
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
