import 'package:ambu/pages/sources.dart';
import 'package:ambu/pages/welcomepage.dart';
import 'package:flutter/material.dart';
import 'ontdekken.dart';
import 'placeholder_widget.dart';
import 'package:ambu/theme/app_theme.dart';
import 'authenticate/authenticate.dart';
import 'package:ambu/services/auth.dart';
import 'package:ambu/pages/personal.dart';

class Homepage extends StatefulWidget {
  //final String title;
  Homepage();

  @override
 State createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage>{
  int _currentIndex = 0;
  String _title = 'Ontdekken';
  final AuthService _auth = AuthService();
  final List _children = [
    ontdekken(),    //PlaceholderWidget(Colors.white),
  //  PlaceholderWidget(Colors.purple),
    personal()
    //PlaceholderWidget(Colors.purple)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        showUnselectedLabels: false,
        selectedItemColor: AppTheme.colors.primaryColor,
        unselectedItemColor: AppTheme.colors.subText,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_outlined),
            label: 'Ontdekken',
          ),
          // new BottomNavigationBarItem(
          //   icon: Icon(Icons.library_books),
          //   label: 'Overzicht',
          // ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_outlined),
              label: 'Profiel'
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xff3FB9F9),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations
                  .of(context)
                  .openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
            _title,
            style: TextStyle(color: AppTheme.colors.primaryColor)
        ),
          actions: <Widget>[

          FlatButton.icon(
      icon: Icon(Icons.person, color: AppTheme.colors.primaryColor),
      label: Text('Uitloggen',
          style: TextStyle(color: AppTheme.colors.primaryColor)),
      onPressed: () async{
        await _auth.signOut();
      },
    ),
    ],
      ),

      body: _children[_currentIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff3FB9F9),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/app_logo.png'),
                    iconSize: 50,
                    onPressed: () { },
                  ),
                  Text(
                    //TODO titel app
                    'Ambu app',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              )

            ),
            // ListTile(
            //   title: const Text('Account',
            //     style: TextStyle(fontSize: 18, color: Color(0xff53617D)),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => personal()));              },
            // ),
            ListTile(
              title: const Text('App info',
                  style: TextStyle(fontSize: 18, color: Color(0xff53617D))),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => IntroScreen()));
              },
            ),
            ListTile(
              title: const Text('Bronnen',
                  style: TextStyle(fontSize: 18, color: Color(0xff53617D))),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => sources()));
              },
            ),
          ],
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0: { _title = 'Ontdekken'; }
        break;
        // case 1: { _title = 'Overzicht'; }
        // break;
        case 1: { _title = 'Profiel'; }
        break;
        //case 3: { _title = 'Clients'; }
        //break;
      }
    });
  }
}


