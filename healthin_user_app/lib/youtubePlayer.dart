import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:convert';
import 'models.dart';

class HealthYoutubePlayer extends StatefulWidget {
  const HealthYoutubePlayer({Key? key}) : super(key: key);

  @override
  State<HealthYoutubePlayer> createState() => _HealthYoutubePlayerState();
}

class _HealthYoutubePlayerState extends State<HealthYoutubePlayer> {
  late YoutubePlayerController _controller;
  Exercise? founddata;
  String name = "랫 풀 다운";
  Future<void> readJson() async {
    //json파일 읽어오기
    final String response =
        await rootBundle.loadString('testjsonfile/healthmachinedata.json');
    //print(response.runtimeType);w
    Map<String, dynamic> _alldata = await jsonDecode(response);
    setState(() {
      for (int i = 0; i < _alldata.length; i++) {
        print(_alldata[i].name);
        if (_alldata[i].name.toString() == name) {
          founddata = Exercise.fromJson(_alldata[i]);
        }
      }
    });
  }

  @override
  void initState() {
    name = "랫 풀 다운";
    readJson();
    super.initState();

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
    _controller.onExitFullscreen = () {
      print('Exited Fullscreen');
    };
  }

  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        YoutubePlayerIFrame(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
        if (founddata != null) Text(founddata!.type.toString()),
      ],
    );
  }
}
