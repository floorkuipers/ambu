import 'dart:convert';
import 'package:ambu/models/scores.dart';
import 'package:ambu/pages/interactive_videos/videodata.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ambu/models/brew.dart';
import 'package:ambu/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
//import 'package:firebase_database/firebase_database.dart';

import '../shared/loading.dart';

Future<MyExcelTable> initialLoad2(uid) async {
MyExcelTable table = MyExcelTable("category", "video", "questionTitle", "question", "answer1", "answer2", "answer3", "correct", true, true,0);
FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      var temp = documentSnapshot['videos'];
      table = MyExcelTable.fromJson(temp);
      return table;
    }
  });
  return table;
}

Future<test> test2(uid) async {
  test table = test("category");
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      var temp = documentSnapshot['videos'];
      table = test.fromJson(temp);
      return table;
    }
  });
  return table;
}

Future<void> initialLoad(uid) async {
  List<MyExcelTable> videos = [];
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
   //if (documentSnapshot.exists) {

     var temp = documentSnapshot['videos'];

      temp.forEach((result){
        videos.add(MyExcelTable.fromJson(temp));
      });
   }
  //});
  );
  print(videos[0]);
}
class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> initialUpload(MyExcelTable myExcelTable) async {
    var path = jsonDecode(saveData(myExcelTable));
        return await users.doc(uid).set(
            {'videos': path}
            , SetOptions(merge: true)
        );
  }

  Future<void> updateUserData(String name) async {
    return await users.doc(uid).set({
      'name': name,
    });
  }

  Future<void> updateScore(
      String topic, String videoTitle, int videoScore) async {
    return await users.doc(uid).set({
      'videos/${topic}/${videoTitle}': videoScore,
    });
  }

  // brew list from snapshot
  List<personalInfo> _namesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return personalInfo(
        name: doc.get('name') ?? 'Pietje Puk',
      );
    }).toList();
  }

  List<scoreList> _scoresFromSnapshot(QuerySnapshot snapshot) {
    QuerySnapshot qn = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get() as QuerySnapshot<Object?>;

    return snapshot.docs.map((doc) {
      //print(doc.data);
      return scoreList(
        scores: doc.get('scores') ?? '',
      );
    }).toList();
  }

  // get brews stream
  Stream<List<personalInfo>> get brews {
    return users.snapshots().map(_namesFromSnapshot);
  }

  Stream<List<scoreList>> get scores {
    return users.snapshots().map(_scoresFromSnapshot);
  }
// Stream<UserData> get userData {
//   return users.doc(uid).snapshots().map(_userDataFromSnapshot);
// }

// Future<void> _getUserName() async {

// users.doc((await FirebaseAuth.instance.currentUser!).uid)
//     .get()
//     .then((value) {
//     _userName = value.data['UserName'].toString();
// });}

}

class GetUserName extends StatefulWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  final _formKey = GlobalKey<FormState>();
  String _currentname = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Er ging iets mis...", style: TextStyle(fontSize: 24));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          _currentname = 'Geen naam opgegeven';
          return Text(_currentname, style: TextStyle(fontSize: 24));
          // return Form(
          //   child: Column(
          //     children: [
          //       TextFormField(
          //         initialValue: _currentname,
          //         //decoration: textInputDecoration,
          //         validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
          //         onChanged: (val) => setState(() => _currentname = val),
          //       ),
          //       RaisedButton(
          //           color: Colors.pink[400],
          //           child: Text(
          //             'Update',
          //             style: TextStyle(color: Colors.white),
          //           ),
          //           onPressed: () async {
          //             if(_formKey.currentState!.validate()){
          //               await DatabaseService(uid: widget.documentId).updateUserData(
          //                 _currentname,
          //               );}
          //           }
          //       )
          //     ],
          //   ),
          // );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          _currentname = data['name'];
          return Text(_currentname, style: TextStyle(fontSize: 24));
        }

        return Loading();
      },
    );
  }
}

class getScores extends StatefulWidget {
  final String documentId;

  getScores(this.documentId);

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _getScores extends State<getScores> {
  final _formKey = GlobalKey<FormState>();
  List _scores = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Er ging iets mis...", style: TextStyle(fontSize: 24));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          _scores = [];
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          _scores = data['scores'];
          //return Text(_currentname,style: TextStyle(fontSize: 24));
        }

        return Loading();
      },
    );
  }
}
