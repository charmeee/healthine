import 'dart:async';
import 'dart:developer';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Routine/models/routine_models.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../models/exerciserecord_model.dart';
import '../providers/exercisedata_provider.dart';

//import './youtubePlayer.dart';

//기본 전체 : 운동기록중엔 루틴을 변경할 수 없다다
const textstyle1 = TextStyle(color: Colors.white);
const double buttonheight = 40;
int tempsec = -1;

class WhileExercise extends ConsumerStatefulWidget {
  const WhileExercise(
      {Key? key,
      required this.routineManuals,
      required this.routineId,
      required this.routineTitle})
      : super(key: key);
  final List<RoutineManual> routineManuals;
  final String routineId;
  final String routineTitle;
  //RoutineData
  @override
  ConsumerState<WhileExercise> createState() => _WhileExerciseState();
}

//휴식 운동중 정지로구분트
class _WhileExerciseState extends ConsumerState<WhileExercise> {
  //final stopwatch = Stopwatch();
  bool timeWatchFlag = false;
  bool isCardio = false; //유산소인가
  String hours = '00';
  String minutes = '00';
  String seconds = '00';
  int speed = 4;
  final duration = const Duration(seconds: 1);
  List<Record> records = [];
  late Record record; //현재 레코드.
  late int nowOrder = 0; //현재 운동순서.
  int restSecond = 120;
  late int beforeLength = 0;
  Timer? _timer;
  int _time = 0; //초단위
  late int findedindex;
  @override
  void initState() {
    super.initState();
    record = Record.init(
        widget.routineManuals[0], widget.routineTitle, widget.routineId);
    final beforeRecord = ref.read(todayRecordProvider);
    beforeLength = beforeRecord.length;
    log("beforeLength : $beforeLength");
    log(widget.routineManuals.length.toString());
    if (beforeRecord.isEmpty) {
      log("운동기록이 없는경우. ");
      //기록이없는 경우
      record = Record.init(
          widget.routineManuals[0], widget.routineTitle, widget.routineId);
    } else {
      //기록이있는경우
      log("운동기록이 있는 경우.");
      nowOrder = beforeRecord.length;
      if (record.setNumber == widget.routineManuals[nowOrder - 1].setNumber) {
        //현재 운동이 끝난경우
        record = Record.init(widget.routineManuals[nowOrder],
            widget.routineTitle, widget.routineId);
      } else {
        record = beforeRecord.last;
        nowOrder--;
      }
    }
    _time = record.playMinute;
    startTimer();
    timeWatchFlag = true;
    if (widget.routineManuals[nowOrder].isCardio) {
      isCardio = true;
    }
  }

  Future<void> sendRecord() async {
    //기록을 보내는 함수
    setState(() {
      record.playMinute = _time;
      record.targetNumber = widget.routineManuals[nowOrder].targetNumber;
    });
    if (beforeLength - 1 == nowOrder) {
      //전에 기록이 있는경우
      await ref
          .read(todayRecordProvider.notifier)
          .editRecordData(record, widget.routineId);
    } else {
      await ref.read(todayRecordProvider.notifier).addRecordData(record);
    }
  }

  void startTimer() {
    _timer = Timer.periodic(duration, (timer) async {
      _time++;
      if (isCardio == false) {
        //유산소가 아니면
        if (_time % speed == 0 && timeWatchFlag) {
          setState(() {
            record.targetNumber++;
          });
          log("개수증가");
        }
        if (record.targetNumber ==
                widget.routineManuals[nowOrder].targetNumber &&
            timeWatchFlag == true) {
          //유산소의 경우 개수 기준으로 카운트해서 멈춤
          //한세트 끝낫을때
          log("세트증가");
          setState(() {
            record.setNumber++;
            record.targetNumber = 0;
            timeWatchFlag = false;
          });
          _timer?.cancel();
          log("스탑워치 멈춤/휴식");
          await Future.delayed(Duration(seconds: restSecond), () {
            log("스탑워치 다시시작!");
            timeWatchFlag = true;
            startTimer();
          });
        }
        if (record.setNumber == widget.routineManuals[nowOrder].setNumber) {
          //현재 운동이 끝난경우
          log("현재운동끝");
          //운동로그 post
          _timer?.cancel();
          timeWatchFlag = false;
          nowOrder++;
          if (widget.routineManuals.length == nowOrder) {
            //전체 루틴이 끝난경우
            await sendRecord();
            log("전체루틴끝");
            Navigator.pop(context); //=> 축하합니다 운동을 완료했습니다
          } else {
            record = Record.init(widget.routineManuals[nowOrder],
                widget.routineTitle, widget.routineId);
          }
          await Future.delayed(Duration(seconds: restSecond * 2), () {
            log("스탑워치 다시시작!");
            timeWatchFlag = true;
            startTimer();
          });
        }
      } else {
        //유산소이면
        if (_time == widget.routineManuals[nowOrder].playMinute) {
          log("유산소 완료");
          setState(() {
            timeWatchFlag = false;
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
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: timeWatchFlag ? Colors.green : Colors.red,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                //이름
                widget.routineManuals[nowOrder].manualTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
              ),
              Text(
                //시간
                '$minutes:$seconds',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 60),
              ),
              if (isCardio == false) ...[
                Text(
                  "${record.targetNumber} / ${widget.routineManuals[nowOrder].targetNumber} 개",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                ),
                Text(
                  "${record.setNumber} / ${widget.routineManuals[nowOrder].setNumber} 세트",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                ),
                Row(
                  //개수 사이 시간
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${speed} 속도",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                speed--;
                              });
                            },
                            icon: Icon(Icons.exposure_minus_1)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                speed++;
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
                      "$restSecond초 휴식",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                restSecond--;
                              });
                            },
                            icon: Icon(Icons.exposure_minus_1)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                restSecond++;
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
                                timeWatchFlag ? Colors.red : Colors.green)),
                        onPressed: () {
                          if (timeWatchFlag) {
                            //스탑워치가 실행중일때 멈추면
                            setState(() {
                              _timer?.cancel();
                              timeWatchFlag = false;
                            });
                          } else {
                            setState(() {
                              timeWatchFlag = true;
                              startTimer();
                            });
                          }
                        },
                        child: timeWatchFlag
                            ? Text("휴식", style: textstyle1)
                            : Text("다시 시작", style: textstyle1),
                      ),
                    ),
                    SizedBox(
                      // height: buttonheight,
                      width: MediaQuery.of(context).size.width / 3 * 0.8,
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            record.playMinute = _time ~/ 60;
                            //post날리고 provider update
                          });
                          await sendRecord();
                          _timer?.cancel();

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
