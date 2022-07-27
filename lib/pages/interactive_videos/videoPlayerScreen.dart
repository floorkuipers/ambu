import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:IVEA/theme/app_theme.dart';
import 'package:IVEA/pages/homepage.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import '../wrapper.dart';
import 'videodata.dart';
import 'question2.dart';

bool videoPlayer = false;

class videoPlayerScreen extends StatefulWidget {
  String topic;

  videoPlayerScreen(this.topic);

  @override
  _videoPlayerScreenState createState() => _videoPlayerScreenState();
}

class _videoPlayerScreenState extends State<videoPlayerScreen>
    with WidgetsBindingObserver {
  // bool videoPlayer = false;
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
  dynamic _video = 'temporary';
  String topic = 'temporary';
  bool playing = videodata.playing;
  int counter = videodata.counter;
  String text = '0';
  final dataset dataSet = new dataset();
  bool test = false;

  void data() {
    topic = widget.topic;

    MyExcelTable data = returnData('$topic$counter');
    _video = data.video;
    controller = VideoPlayerController.asset(
      "videos/$_video.mp4",
    )
      ..addListener(() {
        final bool isPlaying = controller.value.isPlaying;
        // if (controller.value.isPlaying){
        //   playing = true;
        // }
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

        // if (_notification ==null&&
        //       controller.value.position > Duration.zero &&
        //       controller.value.position.inSeconds >=
        //           controller.value.duration.inSeconds) {
        //     dataSet.viewedVideo("$topic$counter");
        //     question2(context, topic);
        //     this.setState(() {
        //       videoPlayer=false;
        //     });
        //   }

        if (_duration.compareTo(_position) == 0) {
          this.setState(() {
            _isEnd = true;
          });
          if (videoPlayer && _notification == null) {
            dataSet.viewedVideo("$topic$counter");
            question2(context, topic);
            if (mounted) this.setState(() {
              videoPlayer = false;
            });
          }
        }

        if (_notification != null) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
        }
      })
      ..initialize().then((value) => controller.play());
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context, listen: false);
    List actualData = dataset.data;
    videoPlayer = true;
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    print(_notification);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0.0,
          iconTheme: IconThemeData(color: AppTheme.colors.primaryColor),
          leading: GestureDetector(
            onTap: () async {
              controller.pause();
              videodata.counter = 1;
              videoPlayer = false;
              for (var j = 0; j < actualData.length; j++) {
                await DatabaseService(uid: user.uid)
                    .initialUpload(actualData[j]);
              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Wrapper()));
            },
            child: Icon(
              Icons.home, // add custom icons also
            ),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              Scaffold(
                  body: Stack(
                    //  fit: isPortrait? StackFit.expand: StackFit.loose,
                      children: [
                Center(
                  child: Container(
                  //width: isPortrait? _height:_width,

                    //  width:_width,
                    // width: _width < _height ? _width : _height,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 10.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Score: ' + totalScore([topic]).toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 1,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (!controller.value.isPlaying) {
                              videodata.playing = true;
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
              ])),
            ],
          ),
        ));
  }
}
