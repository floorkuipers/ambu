import 'package:IVEA/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:IVEA/models/user.dart';
import 'package:IVEA/services/database.dart';
import 'package:IVEA/pages/interactive_videos/videodata.dart';
import 'package:flutter/material.dart';

import '../pages/authenticate/authenticate.dart';

List data = dataset.data;

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon(name, year, geschiedenis) async {
    if(name == ""){
      name = "Pietje Puk";
    }
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(name, year, geschiedenis);
    for (var j = 0; j < data.length; j++) {
      await DatabaseService(uid: user!.uid).initialUpload(data[j]);
     }
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateLocal();

      return user;
    } catch (error) {
      //print(error.toString());
      return null;
    }
  }

  Future resetPassword({required String email, context}) async {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try{
      await _auth
          .sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wachtwoord reset e-mail verzonden. \nCheck ook je Spam folder!"), backgroundColor:Color(0xff3FB9F9),));
      ;
      Navigator.of(context).pop;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Authenticate()));
    }
    on FirebaseAuthException catch(e){
      print(e);
      SnackBar(content: Text(e.message!),);
      Navigator.of(context).pop;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String name, String year, geschiedenis) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(name, year, geschiedenis);
      for (var j = 0; j < data.length; j++) {
        await DatabaseService(uid: user!.uid).initialUpload(data[j]);
      }
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }



}