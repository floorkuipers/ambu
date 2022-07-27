import 'package:IVEA/pages/interactive_videos/training.dart';
import 'package:IVEA/pages/interactive_videos/videoPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import 'videodata.dart';
import 'package:IVEA/theme/app_theme.dart';
import 'package:IVEA/pages/homepage.dart';


question2(BuildContext context, String topic)  {
  final dataset dataSet = new dataset();
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        int counter = videodata.counter;
        MyExcelTable data = returnData('$topic$counter');
          return data.end!=true ? AlertDialog(
            title: Text(data.questionTitle),
            content: Text(data.question),
            actions: [
              TextButton(
          onPressed: ()  async {
                  data.newVideo = false;
                  //data.end? videodata.counter = 1 :
                  videodata.counter++;
                  if(data.correct == 'Answer1'){
                    dataSet.correctAnswer("$topic$counter");
                  }
                  else{
                    dataSet.resetAnswers("$topic$counter");
                  }
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => videoPlayerScreen(topic)));
                 // }
                 },
                child: Text(
                  data.answer1,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () async {
                  data.newVideo = false;
                  videodata.counter++;
                  if(data.correct == 'Answer2'){
                    dataSet.correctAnswer("$topic$counter");
                  }
                  else{
                    dataSet.resetAnswers("$topic$counter");
                  }
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: emptyVideo(topic)?(BuildContext context) => training(data.category):(BuildContext context) => videoPlayerScreen(topic)));

                 // }
                },
                child: Text(
                  data.answer2,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () async {
                  data.newVideo = false;
                  videodata.counter++;
                  if(data.correct == 'Answer3'){
                    dataSet.correctAnswer("$topic$counter");
                  }
                  else{
                    dataSet.resetAnswers("$topic$counter");
                  }
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => videoPlayerScreen(topic)));
                 // }
                },
                child: Text(
                  data.answer3,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
         ):
          _lastVideo(context, topic);
      });
}

Widget _lastVideo(BuildContext context, topic) {
  final user = Provider.of<MyUser>(context, listen: false);
  int counter = videodata.counter;
  MyExcelTable data = returnData('$topic$counter');
  List actualData = dataset.data;
  int score = totalScore([topic]);
  return new AlertDialog(
    title: const Text('Training klaar'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Deze videotraining is afgerond. Je score is $score'),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () async {
          videodata.counter = 1;
            for (var j = 0; j < actualData.length; j++) {
              await DatabaseService(uid: user.uid).initialUpload(actualData[j]);
            }
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => training(data.category)));
          },
        child: const Text('Training afsluiten'),
      ),
    ],
  );
}