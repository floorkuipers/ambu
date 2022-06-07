import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ambu/models/brew.dart';
import 'package:ambu/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String name) async {
    return await users.doc(uid).set({
      'name': name,
    });
  }

  Future<void> updateScore(String videoTitle, int videoScore) async {
    return await users.doc(uid).set({
      'scores/$videoTitle' : videoScore,
    });
  }

  // brew list from snapshot
  List<personalInfo> _namesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return personalInfo(
        name: doc.get('name') ?? '',
      );
    }).toList();
  }

  List<personalInfo> _scoresFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return personalInfo(
        scores: doc.get('name') ?? '',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()!["name"],
    );
  }


  // get brews stream
  Stream<List<personalInfo>> get brews {
    return users.snapshots()
      .map(_namesFromSnapshot);
  }

//   Stream<UserData> get userData {
//     return users.doc(uid).snapshots().map(_userDataFromSnapshot);
//   }

  // Future<void> _getUserName() async {
  //   users.doc((await FirebaseAuth.instance.currentUser!).uid)
  //       .get()
  //       .then((value) {
  //       _userName = value.data['UserName'].toString();
  //   });}

 }


