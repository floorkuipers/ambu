import 'package:IVEA/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'package:IVEA/theme/app_theme.dart';
import 'tiles.dart';
import 'package:IVEA/pages/interactive_videos/videodata.dart';

class ontdekken extends StatefulWidget {
  const ontdekken({Key? key}) : super(key: key);

  @override
  State<ontdekken> createState() => _ontdekkenState();
}

class _ontdekkenState extends State<ontdekken> {
  final String _VHAZ = 'VOORBEHOUDEN HANDELINGEN ACUTE ZORG';
  final String _AZ = 'ACUTE ZORG';
  final String _TV = 'TRAUMA VAARDIGHEDEN';
  final String _LS = 'LIFE SUPPORT';
  final String _VH = '(VOORBEHOUDEN) HANDELINGEN';
  final int counter = videodata.counter;

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);
    DatabaseService(uid: user.uid).updateLocal();
    String category = 'Coniotomie';
    double progress;
    double score;
    if(totalAmount(returnTopic(category)) > 0 && getProgress(returnTopic(category))>0){

      progress = (getProgress(returnTopic(category))/(totalAmount(returnTopic(category))))*100;
      score = ((totalScore(returnTopic(category)))/getProgress(returnTopic(category)))*5;
    } else{
      score = 0;
      progress=0;
    }
      final MyExcelTable data = returnData('$category$counter');

      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        'Recente oefeningen',
                        style: TextStyle(
                          color: AppTheme.colors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Scrollbar(
                      //isAlwaysShown: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(25, 5, 5, 5),
                                child: tiles(category, false, _AZ, category,score, progress)),
                            tiles('Capnografie',false,  _VHAZ, 'capnografie', 5, 90),
                            tiles( 'Bloedglucose meten',false,  _VHAZ, 'bloedglucose-meten', 5, 100),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Meer acute zorg - ademen',
                          style: TextStyle(
                            color: AppTheme.colors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                    Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          tiles("Saturatie", true, _VHAZ, 'saturation', 4, 100),
                          tiles("Beademing", true, _VHAZ, 'breathing-mask', 4, 90),
                          tiles("Zuurstof", true, _VHAZ, 'toedienen-van-zuurstof', 4, 100),
                        ],
                      ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      );
    }
  }
