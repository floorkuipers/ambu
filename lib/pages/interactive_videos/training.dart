import 'package:IVEA/models/scores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:IVEA/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../shared/loading.dart';
import '../homepage.dart';
import '../wrapper.dart';
import 'videodata.dart';
import 'videoPlayerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:IVEA/models/user.dart';
import 'package:IVEA/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//final List topicScores = returnScores();
List duration = [];

class training extends StatefulWidget {
  String category;

  training(this.category);

  @override
  State<training> createState() => _trainingState();
}

class _trainingState extends State<training> {
  @override
  Widget build(BuildContext context) {

    final dataset dataSet = new dataset();
    String category = widget.category;
    final List videoTopics = returnTopic(category);
            return Scaffold(
                appBar: AppBar(
                  leading: Column(children: [
                    // BackButton(
                    //   color: Colors.white,
                    // ),
                  IconButton(
                  icon: const Icon(
                  Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Wrapper()));
                    },
                ),
                  ]),
                  title: PreferredSize(
                    preferredSize: const Size.fromHeight(480.0),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            //ScoreList,
                            category,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Image(
                                image: ExactAssetImage("images/doctor.png"),
                                height: 200.0,
                                alignment: FractionalOffset.bottomRight)),
                      ],
                    ),
                  ),
                  toolbarHeight: 200,
                  backgroundColor: AppTheme.colors.primaryColor,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: AppTheme.colors.primaryColor),
                  flexibleSpace: Image(
                    image: AssetImage('images/bolletjes.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                body: SafeArea(
                    child: ListView.builder(
                  itemCount: videoTopics.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 6,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        leading: CircleAvatar(
                            //child: Text(videoTopics[index]),
                            backgroundColor: AppTheme.colors.primaryColor,
                            child: Icon(Icons.videocam, color: Colors.white)),
                        title: Text(videoTopics[index]),

                        //subtitle: Text(duration[index]),
                        trailing: Text(
                          dataSet.nieuw(videoTopics[index])
                              ? "NIEUW"
                              : "Score: ${(totalScore([
                                      videoTopics[index]
                                    ]))}/${totalAmount([videoTopics[index]])}",
                          style: TextStyle(
                              color: AppTheme.colors.greyedOut, fontSize: 10),
                        ),
                        onTap: () {
                          dataSet.resetAnswers(videoTopics[index]);
                          if (emptyVideo(videoTopics[index]) != true) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        videoPlayerScreen(videoTopics[index])));
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  buildPopupDialog(context),
                            );
                          }
                        }),
                  ),
                ),
                ));
          }
  }


Widget buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Niet beschikbaar'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Deze video is helaas nog niet beschikbaar"),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        //background: AppTheme.colors.primaryColor,
        child: const Text('Sluiten'),
      ),
    ],
  );
}
