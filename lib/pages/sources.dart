import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class sources extends StatefulWidget {
  const sources({Key? key}) : super(key: key);

  @override
  State<sources> createState() => _sourcesState();
}

class _sourcesState extends State<sources> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return BackButton(
                      color: Color(0xff3FB9F9),
            );
          },
        ),
        title: Text(
            "Bronnen",
            style: TextStyle(color: AppTheme.colors.primaryColor)
        ),
      ),
      body: bronnen(),
    ));
  }
}

class bronnen extends StatefulWidget {
  const bronnen({Key? key}) : super(key: key);

  @override
  State<bronnen> createState() => _bronnenState();
}

class _bronnenState extends State<bronnen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Column(children: []),
        leading: Align(
            alignment: Alignment.bottomRight,
            child: Image(
                image: ExactAssetImage("images/doctor.png"),
                alignment: FractionalOffset.center)),
        leadingWidth: 250,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: PreferredSize(
            preferredSize: const Size.fromHeight(200.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Bronnen van videos \nen afbeeldingen'),
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
      body: SafeArea(
        child: ListView(

                children: [
                  Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        leading: CircleAvatar(
                          //child: Text(videoTopics[index]),
                            backgroundColor: AppTheme.colors.primaryColor,
                            child: Icon(Icons.videocam, color: Colors.white)),
                        title: Text('Uitgebreide noodconiotomie', style: TextStyle(fontSize: 13)),
                        //subtitle: Text(duration[index]),
                        trailing: Text('Link'
                          ,
                          style: TextStyle(
                              color: AppTheme.colors.greyedOut, fontSize: 10),
                        ),
                        onTap: () {
                          _launchURL("https://www.youtube.com/watch?v=a4I0MEwtXFY&authuser=3");
                        }),
                  ),

                  Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        leading: CircleAvatar(
                          //child: Text(videoTopics[index]),
                            backgroundColor: AppTheme.colors.primaryColor,
                            child: Icon(Icons.videocam, color: Colors.white)),
                        title: Text('Noodconiotomie op fantoom', style: TextStyle(fontSize: 13)),
                        //subtitle: Text(duration[index]),
                        trailing: Text('Link'
                          ,
                          style: TextStyle(
                              color: AppTheme.colors.greyedOut, fontSize: 10),
                        ),
                        onTap: () {
                          _launchURL("https://www.youtube.com/watch?v=F_PV7N2c2pQ");
                        }),
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        leading: CircleAvatar(
                          //child: Text(videoTopics[index]),
                            backgroundColor: AppTheme.colors.primaryColor,
                            child: Icon(Icons.camera_alt, color: Colors.white)),
                        title: Text('Illustratie verpleegkundige', style: TextStyle(fontSize: 13),),
                        //subtitle: Text(duration[index]),
                        trailing: Text('Link'
                          ,
                          style: TextStyle(
                              color: AppTheme.colors.greyedOut, fontSize: 10),
                        ),
                        onTap: () {
                          _launchURL("https://drawkit.com/product/medical-health-illustrations");
                        }),
                  ),
                ],
              ),
          ),
      );

  }
}
_launchURL(url) async {
  var url2 = Uri.parse(url);
  if (await canLaunchUrl(url2)) {
    await launchUrl(url2);
  } else {
    throw 'Could not launch $url2';
  }
}
