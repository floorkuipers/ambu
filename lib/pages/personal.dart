import 'dart:convert';
import 'dart:developer';

import 'package:ambu/pages/interactive_videos/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:ambu/pages/authenticate/sign_in.dart';
import 'package:provider/provider.dart';
import '../models/brew.dart';
import '../models/user.dart';
import '../services/database.dart';
import 'interactive_videos/videodata.dart';

final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
    .collection("Users")
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .snapshots();

class personal extends StatefulWidget {
  const personal({Key? key}) : super(key: key);

  @override
  State<personal> createState() => _personalState();
}

class _personalState extends State<personal> {
  bool hasType = false;

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);
    setState(() {});

    if (userType.type != '') {
      hasType == true;
    }
    ;

    return Scaffold(
      appBar: AppBar(
        leading: Column(children: []),
        title: FittedBox(
          fit:BoxFit.fitWidth,
          child: PreferredSize(
            preferredSize: const Size.fromHeight(480.0),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GetUserName(user.uid),
                  // child: Text(
                  //   "data",
                  //   style: TextStyle(fontSize: 24),
                  // ),
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
      //  body: Text(test()),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: Text('test'),
          onPressed: () async {
            // MyExcelTable table = await initialLoad2(user.uid);
            // print(table.video);
            test newTest = await test2(user.uid);
            print(newTest.category);
            await initialLoad(user.uid);

          },
        ),
      ),
    );
  }
}
