import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:ambu/pages/authenticate/sign_in.dart';
import 'package:provider/provider.dart';
import '../models/brew.dart';
import '../models/user.dart';
import '../services/database.dart';
import '../shared/loading.dart';

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

    if(userType.type != ''){hasType == true;};

    return StreamBuilder<List<personalInfo>>(
      stream: DatabaseService(uid: user.uid).brews,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<personalInfo>? PersonalInfo = snapshot.data;
          print(PersonalInfo);
          return Scaffold(
            appBar: AppBar(
              leading: Column(children: [
                BackButton(
                  color: Colors.white,
                ),
              ]),
              title: PreferredSize(
                preferredSize: const Size.fromHeight(480.0),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                       // hasType?
                        userType.type
                            //:
                        ,
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
            //body:
          );
        } else {
          return Loading();
        }
      });
  }
}
