import 'package:ambu/pages/interactive_videos/videoPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import 'videodata.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:ambu/pages/homepage.dart';


question2(BuildContext context, String topic)  {


  final dataset dataSet = new dataset();
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        int counter = videodata.counter;
        MyExcelTable data = returnData('$topic$counter');
        return Expanded(
          child: AlertDialog(
            title: Text(data.questionTitle),
            content: Text(data.question),
            actions: [
              TextButton(
          onPressed: ()  {
                  data.newVideo = false;
                  data.end? videodata.counter = 1 : videodata.counter++;
                  if(data.correct == 'Answer1'){
                    dataSet.correctAnswer("$topic$counter");
               //     await DatabaseService(uid: user!.uid).updateScore(topic, data.video, 1);
                  }
                  else{
                    dataSet.resetAnswers("$topic$counter");
                 //   await DatabaseService(uid: user!.uid).updateScore(topic, data.video, 0);

                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: data.end == false?
                          (BuildContext context) => videoPlayerScreen(topic):(BuildContext context) => Homepage()));
                  //Navigator.of(context).pop();

                },
                child: Text(
                  data.answer1,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: ()  {
                  data.newVideo = false;
                  data.end? videodata.counter = 1:videodata.counter++;
                  Navigator.of(context).pop();
                  if(data.correct == 'Answer2'){
                    //videodata.score++;
                    dataSet.correctAnswer("$topic$counter");
               //     await DatabaseService(uid: user!.uid).updateScore(topic, data.video, 1);

                  }
                  else{
                    dataSet.resetAnswers("$topic$counter");
                //    await DatabaseService(uid: user!.uid).updateScore(topic, data.video, 0);
                  }

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: data.end == false?
                          (BuildContext context) => videoPlayerScreen(topic):(BuildContext context) => Homepage()));
                },
                child: Text(
                  data.answer2,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: ()  {
                  data.newVideo = false;
                  data.end? videodata.counter = 1:videodata.counter++;
                  Navigator.of(context).pop();
                  if(data.correct == 'Answer3'){
                   // videodata.score++;
                //    await DatabaseService(uid: user!.uid).updateScore(topic, data.video, 1);
                    dataSet.correctAnswer("$topic$counter");
                  }
                  else{
              //      await DatabaseService(uid: user!.uid).updateScore(topic, data.video, 0);
                    dataSet.resetAnswers("$topic$counter");
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: data.end == false?
                          (BuildContext context) => videoPlayerScreen(topic):(BuildContext context) => Homepage()));
                },
                child: Text(
                  data.answer3,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      });
}
