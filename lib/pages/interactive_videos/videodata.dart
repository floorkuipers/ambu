import 'dart:convert';
import 'package:ambu/pages/interactive_videos/videodata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
//import 'package:firebase_database/firebase_database.dart';


import '../../models/user.dart';

List data = dataset.data;
const jsonCodec = const JsonCodec();

class videodata {
  static int counter = 1;
  static int score = 0;
  static bool playing = false;
}

 saveData(MyExcelTable myExcelTable){
  var json = jsonCodec.encode(myExcelTable);
  return json;
}

@JsonSerializable()
class test{
  String category;
  test(this.category);

  test.fromJson(Map<String, dynamic> json)
      : category = json["category"];
}

@JsonSerializable()
class MyExcelTable {
  String category;
  String video;
  String questionTitle;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String correct;
  bool end;
  bool newVideo = true;
  int score = 0;

  MyExcelTable(this.category, this.video, this.questionTitle, this.question,
      this.answer1, this.answer2, this.answer3, this.correct, this.end, this.newVideo, this.score);

  // MyExcelTable.fromJson(Map<String, dynamic> json)
  //     : category = json["category"],
  //       video = json["video"],
  //       questionTitle = json["questionTitle"],
  //       question = json["question"],
  //       answer1 = json["answer1"],
  //       answer2 = json["answer2"],
  //       answer3 = json["answer3"],
  //       correct = json["correct"],
  //       end = json["end"],
  //       newVideo = json["newVideo"],
  //       score = json["score"];

  static MyExcelTable fromJson(Map<String, dynamic> json) {
    return MyExcelTable(
        json["category"],
        json["video"],
        json["questionTitle"],
      json["question"],
      json["answer1"],
      json["answer2"],
      json["answer3"],
      json["correct"],
      json["end"],
        json["newVideo"],
        json["score"]
    );
  }

  Map toJson() {
    return {
        category: {
        video : {
        "questions": {
          'category': category,
          'video': video,
          'questionTitle': questionTitle,
          'question': question,
          'answer1': answer1,
          'answer2': answer2,
          'answer3': answer3,
          'correct': correct,
          'end': end,
          'newVideo': newVideo,
          'score': score
        }}}
    };
  }
}

class dataset with ChangeNotifier {
  static List<MyExcelTable> data = [
    MyExcelTable('Coniotomie','Doczero1','Fixeren','Wat wordt hier gefixeerd?','Larynx','Luchtpijp', '', 'Answer1', false, true, 0),
    MyExcelTable('Coniotomie', 'Doczero2', 'Palperen', 'Na het palperen van de adamsappel met de wijsvinger beweeg je de vinger tot het ...', 'Cricothyroid membraan', 'Ringkraakbeen', 'Trachea', 'Answer1', false, true, 0),
    MyExcelTable('Coniotomie', 'Doczero3', 'Hoek', 'Onder welke hoek wordt de naald aangeprikt?', '75°', '45°', '30°', 'Answer3', false, true, 0),
    MyExcelTable('Coniotomie', 'Doczero4', '', '', '', '', '', '', true, true,0),
    MyExcelTable("Coniotomie", "Trauma Situatie A1",'Foutmelding', 'Er ging iets fout.', '', 'Sluiten', '', 'no', false, true,0),
    MyExcelTable("Coniotomie", "Uitgebreide_noodconiotomie1", 'Inbrengrichting', 'Moet de naald naar boven of beneden gericht worden bij het inbrengen?', 'Naar boven', 'Naar beneden', '', 'Answer2', false, true,0),
    MyExcelTable("Coniotomie", "Uitgebreide_noodconiotomie2", 'Diep genoeg', 'Hoe weet je dat je de naald diep genoeg ingebracht hebt?', 'Je voelt weerstand', 'Er komt lucht in de naald', 'De naald zit 2cm diep', 'Answer2', false, true,0),
    MyExcelTable("Coniotomie", "Uitgebreide_noodconiotomie3", 'Verwijderen', 'Waar moet je op letten bij het verwijderen van de  naald?', 'Katheter op zijn plek houden', 'De naald op 45° houden', '', 'Answer1', false, true,0),
    MyExcelTable("Coniotomie", "Uitgebreide_noodconiotomie4", '', '', '', '', '', '', true, true,0),
    MyExcelTable("Coniotomie", "Oefenfantoom1", 'Immobiliseren', 'Met welke vingers immobilizeer je de larynx?', 'Duim en middelvinger', 'Wijsvinger en middelvinger', 'Wijsvinger en ringvinger', 'Answer1', false, true,0),
    MyExcelTable("Coniotomie", "Oefenfantoom2", 'Palperen', 'Welke locatie moet je palperen?', '', '', '', '', false, true,0),
    MyExcelTable("Coniotomie", "Oefenfantoom3", 'Hoek', 'Op welke hoek breng je de naald in?', '90°', '45°', '30°', 'Answer3', false, true,0),
    MyExcelTable("Coniotomie", "Oefenfantoom4", 'Trachea', 'Wat is een indicatie dat de naald de trachea bereikt heeft?', 'Lucht in de naald', 'Weerstand', '', '', false, true,0),
    MyExcelTable("Coniotomie", "Oefenfantoom5", '', '', '', '', '', '', true, true,0),

  ];

  void correctAnswer(topic) {
    if(topic.contains(' ')){
      topic = topic.replaceAll(' ','_');
    }
    for (var j = 0; j < data.length; j++) {
      if (data[j].video.contains(topic)) {
        data[j].score = 1;
      }
    }
  }

  void resetAnswers(topic) {
    if(topic.contains(' ')){
      topic = topic.replaceAll(' ','_');
    }
    for (var j = 0; j < data.length; j++) {
      if (data[j].video.contains(topic)) {
        data[j].score = 0;
      }
    }
  }

  void viewedVideo(topic) {
    if(topic.contains(' ')){
      topic = topic.replaceAll(' ','_');
    }
    for (var j = 0; j < data.length; j++) {
      if (data[j].video.contains(topic)) {
        data[j].newVideo = false;
      }
    }
  }

  bool nieuw(topic) {
    bool nieuw = false;
    if(topic.contains(' ')){
      topic = topic.replaceAll(' ','_');
    }
    for (var j = 0; j < data.length; j++) {
      if (data[j].video.contains(topic) &&
          data[j].video.contains('1') &&
          data[j].newVideo) {
        nieuw = true;
      }
    }
    return nieuw;
  }
}

MyExcelTable returnData(String topic) {
  String temp;
  MyExcelTable output = MyExcelTable(
      'Foutmelding', 'Foutmelding', 'Foutmelding', 'Er ging iets fout.', '', 'Sluiten', '', 'no', false, true,0);
  if(topic.contains(' ')){
    topic = topic.replaceAll(' ','_');
  }
  for (var i = 0; i < data.length; i++) {
    if (data[i].video.contains(topic)) {
        output = data[i];
    }
  }
  return output;
}

List returnTopic(category) {
  List outputTopic = [];
  String temp = '';
  for (var j = 0; j < data.length; j++) {
    if (data[j].video.contains('1') && data[j].category == category) {
      temp = data[j].video.replaceAll(RegExp(r'[0-9]'), '');
      //for(var i =1; i<temp.length;i++){
      temp = temp.replaceAll(RegExp(r'[_]'),' ');
      temp.toLowerCase();
      // }
      outputTopic.add(temp);
    }
  }
  return outputTopic;
}


List returnVid(category) {
  List outputTopic = [];
  for (var j = 0; j < data.length; j++) {
    if (data[j].category == category) {
      outputTopic.add(data[j].video);
    }
  }
  return outputTopic;
}
Future<Duration> calcDur(String topic) async {
  Duration duration = Duration(seconds: 0);
  if(topic.contains(' ')){
    topic = topic.replaceAll(' ','_');
  }
  for (var i = 0; i < data.length; i++) {
    if (data[i].video.contains(topic)) {
      String path = data[i].video;
      VideoPlayerController controller = VideoPlayerController.asset(
        "videos/$path.mp4",
      );
      await controller.initialize();
      print(controller.value.duration);
      duration = duration + controller.value.duration;
    }
  }

  return duration;
}

String printDuration(String topic) {
  Duration duration = calcDur(topic) as Duration;
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

// int topicAmount(String topic) {
//   int amount = 0;
//   for (var j = 0; j < data.length; j++) {
//     if (data[j].category.contains(topic)) {
//       amount++;
//     }
//   }
//   return amount - 1;
// }

//total amount of questions available per topic
int totalAmount(List topic) {

  int amount = 0;
  for (var j = 0; j < data.length; j++) {
    for (var i = 0; i < topic.length; i++) {
      if(topic[i].contains(' ')){
        topic[i] = topic[i].replaceAll(' ','_');
      }
      if (data[j].video.contains(topic[i])&&data[j].end ==false) {
        amount++;
      }
    }
  }
  //amount = amount-1;
  return amount;
}

//what is the number of correctly answered questions? Works for both a single topic as for a whole category
int totalScore(List topic) {
  int score = 0;
  int temp;
  for (var j = 0; j < data.length; j++) {
    for (var i = 0; i < topic.length; i++) {
      if(topic[i].contains(' ')){
        topic[i] = topic[i].replaceAll(' ','_');
      }
      if (data[j].video.contains(topic[i]) && data[j].newVideo == false&&data[j].end==false) {
        temp = data[j].score.toInt();
        score += temp;
      }
    }
  }
  return score;
}

//how many questions were answered until now?
int getProgress(List topic) {
  int progress = 0;
  for (var i = 0; i < topic.length; i++) {
    for (var j = 0; j < data.length; j++) {
      if(topic[i].contains(' ')){
        topic[i] = topic[i].replaceAll(' ','_');
      }
      if (data[j].video.contains(topic[i])) {
        if (data[j].newVideo == false&&data[j].end ==false) {
          progress += 1;
        }
      }
    }
  }
  return progress;
}

bool emptyVideo(topic) {
  bool empty = false;
  if(topic.contains(' ')){
    topic = topic.replaceAll(' ','_');
  }
  for (var j = 0; j < data.length; j++) {
    if (data[j].video.contains(topic) && data[j].video.contains('1')) {
      if (data[j].questionTitle.contains('Foutmelding')) {
        empty = true;
      }
    }
  }
  return empty;
}
