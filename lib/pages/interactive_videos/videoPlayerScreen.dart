import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:ambu/pages/homepage.dart';
import 'videodata.dart';
import 'question2.dart';

bool videoPlayer = false;

class videoPlayerScreen extends StatefulWidget {
  String topic;
  videoPlayerScreen(this.topic);

  @override
  _videoPlayerScreenState createState() => _videoPlayerScreenState();
}

class _videoPlayerScreenState extends State<videoPlayerScreen> with WidgetsBindingObserver{

  AppLifecycleState? _notification;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }
  @override
  void initState() {
    data();
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  late VideoPlayerController controller;
  bool _isEnd = false;
  bool _isPlaying = false;
  Duration _duration = Duration(seconds: 0);
  Duration _position = Duration(seconds: 0);
  dynamic _video= 'temporary';
  String topic = 'temporary';
  bool playing = videodata.playing;
  int counter = videodata.counter;
  String text = '0';
  final dataset dataSet = new dataset();

  void data(){
    topic = widget.topic;

    MyExcelTable data = returnData('$topic$counter');
    _video = data.video;
    controller = VideoPlayerController.asset(
      "videos/$_video.mp4",
    )
      ..addListener(() {
        final bool isPlaying = controller.value.isPlaying;
        // if (!controller.value.isPlaying && videodata.counter>1) {
        //   controller.play();
        // }
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }

        Timer.run(() {
          this.setState(() {
            _position = controller.value.position;
          });
        });
        setState(() {
          _duration = controller.value.duration;
        });
        if(
        _duration?.compareTo(_position) == 0){
          this.setState(() {
            _isEnd = true;
          });
          if(videoPlayer && _notification==null){
            dataSet.viewedVideo("$topic$counter");
            question2(context, topic);
            videoPlayer=false;
          }
        }
        if(_notification != null){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Homepage()));
        }
      })
      ..initialize().then((value) => controller.play());
  }


  @override
  Widget build(BuildContext context) {
    print(playing);
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    videoPlayer = true;
      return
     Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0.0,
          iconTheme: IconThemeData(color: AppTheme.colors.primaryColor),
          leading: GestureDetector(
            onTap: () {
              controller.pause();
              videodata.counter=1;
              videoPlayer=false;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Homepage()));},
            child: Icon(
              Icons.home,  // add custom icons also
            ),
          ),
        ),
    body: Stack(
      children: [
        Scaffold(
          body: Column(children: [
            Align(
              alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Score: '+ totalScore([topic]).toString(),
                      style: TextStyle(fontSize: 20),
                    )
                ),
            ),

            Container(
                    width: _width < _height ? _width : _height,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (!controller.value.isPlaying) {
                                videodata.playing = true;
                                print('active');
                                controller.play();
                              } else {
                                controller.pause();
                              }
                              setState(() {});
                            },
                            icon: Icon(controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow)),
                        IconButton(
                            onPressed: () {
                              controller.seekTo(Duration(seconds: 0));

                              setState(() {
                                videodata.counter = 1;
                                MyExcelTable data = returnData('$topic$counter');
                                _video = data.video;
                                controller = VideoPlayerController.asset(
                                  "videos/$_video.mp4",
                                );
                              });
                            },
                            icon: Icon(Icons.stop)),
                      ],
                    ),
                  ),
                ])

        ),
      ],
    ));
  }
}
