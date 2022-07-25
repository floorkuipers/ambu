import 'package:ambu/models/user.dart';
import 'package:ambu/pages/authenticate/authenticate.dart';
import 'package:ambu/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    var page;

    void loggedIn(){
      if (user != null){
        setState(() {
          page = Homepage();
        });
      } else {
        setState(() {
          page = Authenticate();
        });    }
    }
    // return either the Home or Authenticate widget
  loggedIn();
  return WillPopScope(onWillPop: () async => false, child: page);

  }
}