import 'dart:async';
import 'dart:developer';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:healthin/Dictionary/screens/dictionary_detail_screeen.dart';
import 'package:healthin/Dictionary/services/dictionary_api.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../models/exerciserecord_model.dart';
import '../providers/exercisedata_provider.dart';
import '../widgets/progress_bar.dart';

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
  int nowOrder = 0; //현재 운동순서.
  int restSecond = 60;
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
  }

  initTimer() {
    setState(() {
      _time = 0;
      _timer?.cancel();
      timeWatchFlag = false;
    });
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
    return WillPopScope(
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
                          initTimer();
                          tts.stop();

                          flag = true;
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: Text("확인")),
                  ],
                ));
        return Future.value(flag);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('$minutes:$seconds'),
          centerTitle: false,
          backgroundColor: backgroundColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              color: darkGrayColor,
              height: 1,
            ),
          ),
        ),
        body: Container(
          color: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StepProgressView(
                  maxStep: widget.routineManuals.length,
                  curStep: nowOrder,
                ),
                _progressIndicator(),
                Text(
                  //이름
                  widget.routineManuals[nowOrder].manualTitle,
                  textAlign: TextAlign.center,
                  style: h1Regular_24,
                ),
                if (!timeWatchFlag)
                  Text(
                    "휴식중",
                    style: h2Regular_22,
                  ),
                _controlButtons(),
                if (!isCardio) _setCounter(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: darkGrayColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                  icon: SvgPicture.asset("assets/icons/finished_active.svg")),
              IconButton(
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
                  icon: SvgPicture.asset(timeWatchFlag
                      ? "assets/icons/pause.svg"
                      : "assets/icons/play_arrow.svg")),
              IconButton(
                  onPressed: () async {
                    ManualData manualData = await getDictionaryByManualId(
                        widget.routineManuals[nowOrder].manualId);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DictionaryDetail(
                              founddata: manualData,
                            )));
                  },
                  icon: SvgPicture.asset("assets/icons/books.svg")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressIndicator() {
    return CircularPercentIndicator(
      radius: 104,
      lineWidth: 30.0,
      percent: isCardio
          ? 1
          : nowRecord.targetNumber /
              widget.routineManuals[nowOrder].targetNumber,
      center: isCardio
          ? Text(
              '$minutes:$seconds',
              style: h1Bold_24.copyWith(color: Color(0xFFA2A3A3)),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${nowRecord.targetNumber}',
                  style: h1Bold_24.copyWith(color: primaryColor),
                ),
                Text(
                  '/${widget.routineManuals[nowOrder].targetNumber}',
                  style: h1Bold_24.copyWith(color: Color(0xFFA2A3A3)),
                )
              ],
            ),
      progressColor: isCardio ? bulletPurpleColor : primaryColor,
    );
  }

  Widget _setCounter() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.routineManuals[nowOrder].setNumber,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(bottom: 8),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}set",
                    style: bodyBold_16,
                  ),
                  Text(
                    "${widget.routineManuals[nowOrder].weight}kg",
                    style: bodyRegular_16,
                  ),
                  Text("${widget.routineManuals[nowOrder].targetNumber}회",
                      style: bodyRegular_16),
                  SvgPicture.asset(
                    "assets/icons/finished.svg",
                    width: 16,
                    height: 16,
                    color: nowRecord.setNumber > index
                        ? primaryColor
                        : const Color(0xFFA2A3A3),
                  ),
                ],
              ));
        });
  }

  Widget _controlButtons() {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  if (countSpeed > 1 && !isCardio) {
                    setState(() {
                      countSpeed--;
                    });
                  }
                },
                icon: SvgPicture.asset("assets/icons/delete_withborder.svg")),
            Text(
              "$countSpeed 속도",
              textAlign: TextAlign.center,
              style: h1Regular_24.copyWith(fontSize: 22),
            ),
            IconButton(
                onPressed: () {
                  if (!isCardio) {
                    setState(() {
                      countSpeed++;
                    });
                  }
                },
                icon: SvgPicture.asset("assets/icons/add_withborder.svg"))
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  if (restSecond > 0) {
                    setState(() {
                      restSecond--;
                    });
                  }
                },
                icon: SvgPicture.asset("assets/icons/delete_withborder.svg")),
            Text(
              "$restSecond초 휴식",
              textAlign: TextAlign.center,
              style: h1Regular_24.copyWith(fontSize: 22),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    restSecond++;
                  });
                },
                icon: SvgPicture.asset("assets/icons/add_withborder.svg"))
          ],
        ),
      ],
    );
  }

  void startTimer() {
    log(nowOrder.toString() + "번째 운동 시작");
    setState(() {
      timeWatchFlag = true;
    });
    _timer = Timer.periodic(duration, (timer) async {
      setState(() {
        _time++;
        seconds = (_time % 60).toString().padLeft(2, '0');
        minutes = (_time ~/ 60).toString().padLeft(2, "0");
      });
      if (!isCardio) {
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
          initTimer();
          setState(() {
            nowRecord.setNumber++;
            nowRecord.targetNumber = 0;
          });
          if (nowRecord.setNumber ==
              widget.routineManuals[nowOrder].setNumber) {
            //nowRecord finished
            log("현재운동끝");
            await sendRecord();
            initTimer();
            setState(() {
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
          initTimer();
          setState(() {
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
}
