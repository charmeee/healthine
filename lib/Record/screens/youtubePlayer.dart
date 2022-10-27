import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:convert';
import '../../Routine/models/routine_models.dart';

// 내가봣을때 걍 유튜브링크 넘겨줘서 webview로 보는게 더 맞는거 가틈..

class HealthYoutubePlayer extends StatefulWidget {
  const HealthYoutubePlayer({Key? key}) : super(key: key);

  @override
  State<HealthYoutubePlayer> createState() => _HealthYoutubePlayerState();
}

class _HealthYoutubePlayerState extends State<HealthYoutubePlayer> {
  late YoutubePlayerController _controller;
  ManualData? founddata;
  String Exercisename = "랫 풀 다운";
  Future<void> readJson() async {
    //json파일 읽어오기
    final String response =
        await rootBundle.loadString('testjsonfile/healthmachinedata.json');
    //print(response.runtimeType);w
    Map<String, dynamic> _alldata = await jsonDecode(response);
    setState(() {
      for (int i = 0; i < _alldata["exerciseType"].length; i++) {
        //print(_alldata["exerciseType"][0]["name"]);
        if (_alldata["exerciseType"][i]["name"].toString() == Exercisename) {
          founddata = ManualData.fromJson(_alldata["exerciseType"][i]);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Exercisename = "랫 풀 다운";
    readJson();

    _controller = YoutubePlayerController(
      initialVideoId: "txL-itZYdY4",
      params: const YoutubePlayerParams(
        mute: false,
        autoPlay: false,
        loop: false,
        showControls: true,
        showFullscreenButton: true,
        enableCaption: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      print('Entered Fullscreen');
    };
    // _controller.onExitFullscreen = () {
    //   print('Exited Fullscreen');
    // };
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            Exercisename,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),
          ),
          YoutubePlayerIFrame(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
          if (founddata != null)
            Text(
              founddata!.type.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
        ],
      ),
    );
  }
}
