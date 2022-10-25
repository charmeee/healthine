// import 'dart:async';
// import 'dart:developer';
// import 'package:drift/drift.dart' show Value;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:healthin/Routine/routine_models.dart';
//
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/material.dart';
//
// //import './youtubePlayer.dart';
//
// const textstyle1 = TextStyle(color: Colors.white);
// const double buttonheight = 40;
// int tempsec = -1;
//
// class WhileExercise extends ConsumerStatefulWidget {
//   const WhileExercise(
//       {Key? key, required this.routine, required this.routineId})
//       : super(key: key);
//   final List<RoutineManual> routine;
//   final String routineId;
//   //RoutineData
//   @override
//   ConsumerState<WhileExercise> createState() => _WhileExerciseState();
// }
//
// //휴식 운동중 정지로구분트
// class _WhileExerciseState extends ConsumerState<WhileExercise> {
//   //final stopwatch = Stopwatch();
//   bool timewatchflag = false;
//   bool isAEROBIC = false; //유산소인가
//   String hours = '00';
//   String minutes = '00';
//   String seconds = '00';
//   final duration = const Duration(seconds: 1);
//   late UserExerciseData exerciseData;
//   late RoutineData routineData;
//   //late Map exerciseSet;
//   //int getTime = 0; //넘겨줄시간
//   Timer? _timer;
//   var _time = 0;
//   late int findedindex;
//   @override
//   void initState() {
//     super.initState();
//     routineData = ref
//         .read(RoutineNotifierProvider)
//         .firstWhere((element) => element.id == widget.routineid);
//     exerciseData = UserExerciseData(routineData: routineData);
//     if (widget.userExerciseId != null) {
//       //기록이 있는경우
//       ref
//           .read(localDatabaseProvider)
//           .getExerciseRecordById(widget.userExerciseId)
//           .then((value) {
//         log("values" + value.toString());
//
//         exerciseData = UserExerciseData(
//             routineData: RoutineData(
//                 name: value.name,
//                 type: value.type,
//                 status: routineStatus.getByString(value.status),
//                 totalTime: value.totalTime,
//                 totalSet: value.totalSet,
//                 numPerSet: value.numPerSet,
//                 weight: value.weight),
//             doingSet: value.doingSet,
//             doingTime: value.doingTime,
//             doingNum: value.doingNum);
//       });
//
//       log("-----db에서 가져온 데이터-----");
//       log(exerciseData.toString());
//       //localdb에있는 정보를 가져옴.
//       // exerciseData = ref
//       //     .read(UserExercisedNotifierProvider)
//       //     .firstWhere((element) => element.id == widget.userExerciseId);
//       _time = exerciseData.doingTime;
//     }
//     startTimer();
//     timewatchflag = true;
//     if (widget.type == "유산소") {
//       isAEROBIC = true;
//     }
//   }
//
//   void startTimer() {
//     _timer = Timer.periodic(duration, (timer) async {
//       _time++;
//       if (isAEROBIC == false) {
//         //유산소가 아니면
//         if (_time % exerciseData.countInterver == 0 && timewatchflag) {
//           exerciseData.doingNum = exerciseData.doingNum + 1;
//           log("개수증가");
//         }
//         if (exerciseData.doingNum ==
//                 routineData.numPerSet * exerciseData.doingSet + 1 &&
//             timewatchflag == true) {
//           //유산소의 경우 개수 기준으로 카운트해서 멈춤
//           //한세트 끝낫을때
//           log("세트증가");
//           exerciseData.doingSet = exerciseData.doingSet + 1;
//           setState(() {
//             timewatchflag = false;
//           });
//           _timer?.cancel();
//           log("스탑워치 멈춤/휴식");
//           await Future.delayed(Duration(seconds: exerciseData.restTime), () {
//             log("스탑워치 다시시작!");
//             timewatchflag = true;
//             startTimer();
//           });
//         }
//       } else {
//         //유산소이면
//         if (_time == routineData.totalTime) {
//           log("유산소 완료");
//           setState(() {
//             timewatchflag = false;
//           });
//           _timer?.cancel();
//         }
//       }
//       setState(() {
//         minutes = (_time ~/ 60).toString().padLeft(2, "0");
//         seconds = (_time % 60).toString().padLeft(2, "0");
//         //log("stringsec" + seconds);
//         //log(stopwatch.elapsed.inSeconds.toString());
//       });
//     }); //Timer(Duration duration, void callback())
//   }
//
//   @override
//   void dispose() {
//     // TODO: 시간을 상위 state에 넘겨 줘야함.
//
//     super.dispose();
//     _timer?.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     routineData = ref
//         .watch(RoutineNotifierProvider)
//         .firstWhere((element) => element.id == widget.routineid); //구독
//     final routineDataRead = ref.read(RoutineNotifierProvider.notifier);
//     final userExercisedRead =
//         ref.read(UserExercisedNotifierProvider.notifier); //함수들
//     return Scaffold(
//       body: Container(
//         color: timewatchflag ? Colors.green : Colors.red,
//         padding: EdgeInsets.all(10),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 //이름
//                 routineData.name,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
//               ),
//               Text(
//                 //시간
//                 '$minutes:$seconds',
//                 style: TextStyle(fontWeight: FontWeight.w300, fontSize: 60),
//               ),
//               if (isAEROBIC == false) ...[
//                 Row(
//                   //현 개수 / 총 개수
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "${exerciseData.doingNum != 0 ? (exerciseData.doingNum - 1) % (routineData.numPerSet) + 1 : 0} / ${routineData.numPerSet} 개",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               if (routineData.numPerSet != 0) {
//                                 routineDataRead.editRoutineDataById(
//                                     routineId: widget.routineid,
//                                     props: "num",
//                                     value: -1);
//                               }
//                             },
//                             icon: Icon(Icons.exposure_minus_1)),
//                         IconButton(
//                             onPressed: () {
//                               if (routineData.numPerSet != 0) {
//                                 routineDataRead.editRoutineDataById(
//                                     routineId: widget.routineid,
//                                     props: "num",
//                                     value: 1);
//                               }
//                             },
//                             icon: Icon(Icons.plus_one))
//                       ],
//                     )
//                   ],
//                 ),
//                 Row(
//                   //현세트 / 총세트
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "${exerciseData.doingSet} / ${routineData.totalSet} 세트",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               if (routineData.totalSet != 0) {
//                                 routineDataRead.editRoutineDataById(
//                                     routineId: widget.routineid,
//                                     props: "set",
//                                     value: -1);
//                               }
//                             },
//                             icon: Icon(Icons.exposure_minus_1)),
//                         IconButton(
//                             onPressed: () {
//                               if (routineData.totalSet != 0) {
//                                 routineDataRead.editRoutineDataById(
//                                     routineId: widget.routineid,
//                                     props: "set",
//                                     value: 1);
//                               }
//                             },
//                             icon: Icon(Icons.plus_one))
//                       ],
//                     )
//                   ],
//                 ),
//                 Row(
//                   //개수 사이 시간
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "${exerciseData.countInterver} 속도",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 exerciseData.countInterver--;
//                               });
//                             },
//                             icon: Icon(Icons.exposure_minus_1)),
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 exerciseData.countInterver++;
//                               });
//                             },
//                             icon: Icon(Icons.plus_one))
//                       ],
//                     )
//                   ],
//                 ),
//                 Row(
//                   //쉬는시간
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "${exerciseData.restTime} 휴식",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 exerciseData.restTime--;
//                               });
//                             },
//                             icon: Icon(Icons.exposure_minus_1)),
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 exerciseData.restTime++;
//                               });
//                             },
//                             icon: Icon(Icons.plus_one))
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//               SizedBox(
//                 height: 100,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(
//                       // height: buttonheight,
//                       width: MediaQuery.of(context).size.width / 3 * 0.8,
//                       child: TextButton(
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(
//                                 timewatchflag ? Colors.red : Colors.green)),
//                         onPressed: () {
//                           if (timewatchflag) {
//                             //스탑워치가 실행중일때 멈추면
//                             setState(() {
//                               _timer?.cancel();
//                               timewatchflag = false;
//                             });
//                           } else {
//                             setState(() {
//                               startTimer();
//                               timewatchflag = true;
//                             });
//                           }
//                         },
//                         child: timewatchflag
//                             ? Text("휴식", style: textstyle1)
//                             : Text("다시 시작", style: textstyle1),
//                       ),
//                     ),
//                     SizedBox(
//                       // height: buttonheight,
//                       width: MediaQuery.of(context).size.width / 3 * 0.8,
//                       child: TextButton(
//                         onPressed: () {
//                           setState(() {
//                             exerciseData.doingTime = _time;
//
//                             if (widget.userExerciseId == null) {
//                               // userExercisedRead.add(exerciseData);
//                               ref
//                                   .read(localDatabaseProvider)
//                                   .createExerciseRecord(
//                                       ExerciseRecordsCompanion(
//                                     id: Value(exerciseData.id),
//                                     name: Value(exerciseData.name),
//                                     type: Value(exerciseData.type),
//                                     status:
//                                         Value(exerciseData.status.toString()),
//                                     doingTime: Value(exerciseData.doingTime),
//                                     weight: Value(exerciseData.weight),
//                                     doingSet: Value(exerciseData.doingSet),
//                                     doingNum: Value(exerciseData.doingNum),
//                                     numPerSet: Value(exerciseData.numPerSet),
//                                     totalSet: Value(exerciseData.totalSet),
//                                     totalTime: Value(exerciseData.totalTime),
//                                   ));
//                             } else {
//                               // userExercisedRead.replace(
//                               //     exerciseData, widget.userExerciseId);
//                               ref
//                                   .read(localDatabaseProvider)
//                                   .updateExerciseRecordById(
//                                       exerciseData.id,
//                                       ExerciseRecordsCompanion(
//                                         status: Value(
//                                             exerciseData.status.toString()),
//                                         doingTime:
//                                             Value(exerciseData.doingTime),
//                                         weight: Value(exerciseData.weight),
//                                         doingSet: Value(exerciseData.doingSet),
//                                         doingNum: Value(exerciseData.doingNum),
//                                         numPerSet:
//                                             Value(exerciseData.numPerSet),
//                                         totalSet: Value(exerciseData.totalSet),
//                                         totalTime:
//                                             Value(exerciseData.totalTime),
//                                       ));
//                             }
//                             _timer?.cancel();
//                           });
//                           Future.delayed(
//                               Duration(
//                                 milliseconds: 10,
//                               ), () {
//                             Navigator.of(context).pop();
//                           });
//                         },
//                         //Navigator.of(context).popUntil((route) => route.isFirst)
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.black54)),
//                         child: Text(
//                           "운동 완료",
//                           style: textstyle1,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       // height: buttonheight,
//                       width: MediaQuery.of(context).size.width / 3 * 0.8,
//                       child: TextButton(
//                         onPressed: () => {
//                           launchUrl(Uri.parse(
//                               "https://www.youtube.com/watch?v=2K2WCGstHOY"))
//                         },
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.black54)),
//                         child: Text(
//                           "운동 방법",
//                           style: textstyle1,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
