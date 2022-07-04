import 'dart:convert';
import 'dart:developer';
import 'package:ambu/pages/authenticate/register.dart';
import 'package:ambu/pages/interactive_videos/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:ambu/pages/authenticate/sign_in.dart';
import 'package:provider/provider.dart';
import '../models/brew.dart';
import '../models/user.dart';
import '../services/database.dart';
import '../shared/constants.dart';
import 'interactive_videos/videodata.dart';

// final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
//     .collection("Users")
//     .doc(FirebaseAuth.instance.currentUser?.uid)
//     .snapshots();

class personal extends StatefulWidget {
  const personal({Key? key}) : super(key: key);

  @override
  State<personal> createState() => _personalState();
}

class _personalState extends State<personal> {
  int bugcount = 0;
  bool hasType = false;
  String bug = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

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
       // leading: Column(children: []),
        leading: Align(
            alignment: Alignment.bottomRight,
            child: Image(
                image: ExactAssetImage("images/doctor.png"),
                alignment: FractionalOffset.center)), leadingWidth: 250,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: PreferredSize(
            preferredSize: const Size.fromHeight(200.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GetUserName(user.uid),
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: 130,
        backgroundColor: AppTheme.colors.primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppTheme.colors.primaryColor),
        flexibleSpace: Image(
          image: AssetImage('images/bolletjes.png'),
          fit: BoxFit.cover,
        ),
      ),
      //  body: Text(test()),
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 30),
                        child: Text(
                          "Ervaar je een probleem met de app? Laat het hieronder weten.",
                          style: TextStyle(fontSize: 17, color: AppTheme.colors.textColor),
                        )),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Wat ging er niet goed?'),
                      onChanged: (val) {
                        setState(() => bug = val);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppTheme.colors.accentColor,
                          ),
                          child: Text(
                            'Verzenden',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            bugcount++;
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                                return await users.doc(user.uid).update({
                                    'bug$bugcount' : bug
                                });
                            }
                          }),
                    ),
                  ],
                ),
              )
    ),
        ),
      ),
    );
  }
}
