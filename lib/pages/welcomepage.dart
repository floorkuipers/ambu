import 'package:ambu/pages/walkthrough.dart';
import 'package:ambu/pages/wrapper.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == 3) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: BoxDecoration(color: AppTheme.colors.primaryColor),
          ),
      Container(
        color: Color(0xFFEEEEEE),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: PageView(
                children: <Widget>[
                  Walkthrough(
                    // TODO: insert appname
                    title: "Bedankt voor het downloaden van deze app",
                    content: "Flutkart.wc1",
                    imageIcon: Icons.mobile_screen_share,

                  ),
                  Walkthrough(
                    title: "Deze app is onderdeel van mijn afstudeerscriptie",
                    //TODO: schrijf omschrijving van deze app en mijn scriptie
                    content: "Flutkart.wc2",
                    imageIcon: Icons.search,
                  ),
                  Walkthrough(
                    title: "Hoe werkt de app?",
                    //TODO: schrijf uitleg van de app
                    content: "Flutkart.wc3",
                    imageIcon: Icons.shopping_cart,
                  ),
                  Walkthrough(
                    title: "Flutkart.wt4",
                    content: "Flutkart.wc4",
                    imageIcon: Icons.verified_user,
                  ),
                ],
                controller: controller,
                onPageChanged: _onPageChanged,
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text(lastPage ? "Klaar" : "Volgende",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                      onPressed: () => lastPage
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Wrapper()))
                          : controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]));
  }
}
