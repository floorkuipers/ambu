import 'package:ambu/models/user.dart';
import 'package:ambu/pages/authenticate/authenticate.dart';
import 'package:ambu/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    // return either the Home or Authenticate widget
    if (user != null){
      return Homepage();
    } else {
      return Authenticate();
    }

  }
}