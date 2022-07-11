import 'dart:async';

import 'package:flutter/material.dart';

class WhileExercise extends StatefulWidget {
  const WhileExercise({Key? key}) : super(key: key);

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

  void initState() {
    stopwatch.start();
    startTimer();
    flag = true;
  }

  void startTimer() {
    Timer(duration, keepRunning); //Timer(Duration duration, void callback())
  }

  void keepRunning() {
    if (stopwatch.isRunning) {
      startTimer();
    }

    setState(() {
      hours = stopwatch.elapsed.inHours.toString().padLeft(2, "0");
      minutes = (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0");
      seconds = (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void dispose() {
    // TODO: implement dispose
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$hours:$minutes:$seconds',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
              ),
              IconButton(
                icon: Icon(Icons.start),
                onPressed: () {
                  if (flag) {
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
              TextButton(
                  onPressed: () => {
                        Navigator.of(context).popUntil((route) => route.isFirst)
                      },
                  child: Text("운동완료"))
            ],
          ),
        ),
      ),
    );
  }
}
