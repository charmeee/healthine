import 'dart:async';
import 'dart:developer';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  int countSpeed = 4;
  final duration = const Duration(seconds: 1);
  List<Record> records = [];
  late Record nowRecord; //현재 레코드.
  late int nowOrder = 0; //현재 운동순서.
  int restSecond = 120;
  int beforeLength = 0;
  Timer? _timer;
  int _time = 0; //초단위

  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    tts.setLanguage("ko-KR");
    tts.setSpeechRate(0.5);
    nowRecord = Record.init(
        widget.routineManuals[0], widget.routineTitle, widget.routineId);
    final beforeRecord = ref.read(todayRecordProvider);
    beforeLength = beforeRecord.length;
    log("beforeLength : ${beforeRecord.length}");
    log(widget.routineManuals.length.toString());
    if (beforeRecord.isEmpty) {
      log("운동기록이 없는경우. ");
    } else {
      log("운동기록이 있는 경우.");
      nowOrder = beforeRecord.length;
      if (beforeRecord[nowOrder - 1].setNumber ==
          widget.routineManuals[nowOrder - 1].setNumber) {
        //현재 운동이 끝난경우
        nowRecord = Record.init(widget.routineManuals[nowOrder],
            widget.routineTitle, widget.routineId);
      } else {
        //운동이안끝난경우.
        nowRecord = beforeRecord[nowOrder - 1];
        nowRecord.targetNumber = 0;
        _time = nowRecord.playMinute;
        nowOrder--;
      }
    }
    if (widget.routineManuals[nowOrder].isCardio) {
      isCardio = true;
    }
    startTimer();
  }

  Future<void> sendRecord() async {
    //기록을 보내는 함수
    if (0 < nowRecord.targetNumber &&
        nowRecord.targetNumber < widget.routineManuals[nowOrder].targetNumber) {
      return;
    }
    if (0 == nowRecord.targetNumber && nowRecord.setNumber == 0) {
      return;
    }
    setState(() {
      nowRecord.playMinute = _time ~/ 60;
      nowRecord.targetNumber = widget.routineManuals[nowOrder].targetNumber;
    });
    if (beforeLength - 1 == nowOrder) {
      //전에 기록이 있는경우
      await ref.read(todayRecordProvider.notifier).editRecordData(nowRecord);
    } else {
      await ref.read(todayRecordProvider.notifier).addRecordData(nowRecord);
    }
    setState(() {
      _time = 0;
    });
  }

  void startTimer() {
    setState(() {
      timeWatchFlag = true;
    });
    _timer = Timer.periodic(duration, (timer) async {
      setState(() {
        _time++;
        seconds = (_time % 60).toString().padLeft(2, '0');
        minutes = (_time ~/ 60).toString().padLeft(2, "0");
      });
      if (isCardio == false) {
        //유산소가 아니면
        if (_time % countSpeed == 0 && timeWatchFlag) {
          setState(() {
            nowRecord.targetNumber++;
            tts.speak(nowRecord.targetNumber.toString());
          });
          log("개수증가");
        }
        if (nowRecord.targetNumber ==
                widget.routineManuals[nowOrder].targetNumber &&
            timeWatchFlag) {
          //유산소의 경우 개수 기준으로 카운트해서 멈춤
          //한세트 끝낫을때
          log("세트증가");
          setState(() {
            nowRecord.setNumber++;
            nowRecord.targetNumber = 0;
            timeWatchFlag = false;
            _timer?.cancel();
          });
          if (nowRecord.setNumber ==
              widget.routineManuals[nowOrder].setNumber) {
            //nowRecord finished
            log("현재운동끝");
            await sendRecord();
            setState(() {
              _timer?.cancel();
              timeWatchFlag = false;
              nowOrder++;
            });
            if (widget.routineManuals.length == nowOrder) {
              //전체 루틴이 끝난경우
              log("전체루틴끝");
              Navigator.popUntil(
                  context, (route) => route.isFirst); //=> 축하합니다 운동을 완료했습니다
            } else {
              //다음루틴시작.
              setState(() {
                nowRecord = Record.init(widget.routineManuals[nowOrder],
                    widget.routineTitle, widget.routineId);
                widget.routineManuals[nowOrder].isCardio
                    ? isCardio = true
                    : isCardio = false;
              });
            }
          }
          log("스탑워치 멈춤/휴식");
          await Future.delayed(Duration(seconds: restSecond), () {
            log("스탑워치 다시시작!");
            startTimer();
          });
        }
      } else {
        //유산소이면
        if (_time == widget.routineManuals[nowOrder].playMinute &&
            timeWatchFlag) {
          log("유산소 완료");
          await sendRecord();
          setState(() {
            _time = 0;
            _timer?.cancel();
            timeWatchFlag = false;
            nowOrder++;
          });
          log("스탑워치 멈춤/휴식");
          if (widget.routineManuals.length == nowOrder) {
            //전체 루틴이 끝난경우
            log("전체루틴끝");
            Navigator.popUntil(
                context, (route) => route.isFirst); //=> 축하합니다 운동을 완료했습니다
          } else {
            //다음루틴시작.
            setState(() {
              nowRecord = Record.init(widget.routineManuals[nowOrder],
                  widget.routineTitle, widget.routineId);
              widget.routineManuals[nowOrder].isCardio
                  ? isCardio = true
                  : isCardio = false;
            });
          }
          await Future.delayed(Duration(seconds: restSecond), () {
            log("스탑워치 다시시작!");
            startTimer();
          });
        }
      }
    }); //Timer(Duration duration, void callback())
  }

  @override
  void dispose() {
    // TODO: 시간을 상위 state에 넘겨 줘야함.
    _timer?.cancel();
    tts.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          bool flag = false;

          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("운동을 종료하시겠습니까?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("아니오")),
                      TextButton(
                          onPressed: () async {
                            await sendRecord();
                            _timer?.cancel();
                            tts.stop();

                            flag = true;
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: Text("확인")),
                    ],
                  ));
          return Future.value(flag);
        },
        child: Container(
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
                    "${nowRecord.targetNumber} / ${widget.routineManuals[nowOrder].targetNumber} 개",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                  ),
                  Text(
                    "${nowRecord.setNumber} / ${widget.routineManuals[nowOrder].setNumber} 세트",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
                  ),
                  Row(
                    //개수 사이 시간
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${countSpeed} 속도",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 35),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (countSpeed > 1) {
                                  setState(() {
                                    countSpeed--;
                                  });
                                }
                              },
                              icon: Icon(Icons.exposure_minus_1)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  countSpeed++;
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
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 35),
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
                              startTimer();
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
                            Navigator.of(context).maybePop();
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
      ),
    );
  }
}
