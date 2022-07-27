import 'package:IVEA/pages/interactive_videos/videoPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:IVEA/pages/interactive_videos/videodata.dart';
import 'package:IVEA/theme/app_theme.dart';

class question extends StatefulWidget {
  String topic;
  //int counter;
  question(this.topic);

  @override
  State<question> createState() => _questionState();
}

class _questionState extends State<question> {
  String topic = 'temporary';

  @override
  Widget build(BuildContext context) {
    //int counter = widget.counter;
    String topic = widget.topic;
    int counter = videodata.counter;
    MyExcelTable data = returnData('$topic$counter');

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0.0,
          iconTheme: IconThemeData(color: AppTheme.colors.primaryColor),
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.question),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        videodata.counter++;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => videoPlayerScreen(topic)));
                      });
                    },
                    child: Text(data.answer1),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        videodata.counter++;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => videoPlayerScreen(topic)));
                      });
                    },
                    child: Text(data.answer2),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => videoPlayerScreen(topic)));
                        videodata.counter++;
                      });
                    },
                    child: Text(data.answer3),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
