// @dart=2.9
import 'package:ambu/pages/initialrouting.dart';
import 'package:ambu/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ambu/models/user.dart';
import 'package:ambu/pages/homepage.dart';
import 'package:ambu/pages/wrapper.dart';
import 'package:ambu/pages/initialrouting.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   theme: ThemeData(fontFamily: 'Roboto'),
    //
    //   home: Homepage(),
    // );
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
