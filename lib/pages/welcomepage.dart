import 'package:ambu/pages/walkthrough.dart';
import 'package:ambu/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ambu/models/appInfo.dart';
import '../theme/app_theme.dart';
import 'authenticate/authenticate.dart';

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

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/infoschermBolletjes.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
          body: Stack(fit: StackFit.expand, children: <Widget>[
               Container(
                color: Color(0xFFEEEEEE),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(child: Row(
                          children: [
                            Image.asset(
                              'images/app_logo.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10.0),
                            Text('IVEA', style: TextStyle(fontSize: 25, color: AppTheme.colors.primaryColor, fontWeight: FontWeight.bold),)
                          ],
                        )),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: PageView(
                        children: <Widget>[
                          Walkthrough(
                            // TODO: insert appname
                            title: appInfo.bedankt,
                            content: appInfo.bedanktText,
                            // imageIcon: Icons.mobile_screen_share,

                          ),
                          Walkthrough(
                            title: appInfo.hoe,
                            content: appInfo.hoeText,
                            // imageIcon: Icons.search,
                          ),
                          Walkthrough(
                            title: appInfo.gegevens,
                            content: appInfo.gegevensText,
                            //   imageIcon: Icons.shopping_cart,
                          ),
                          Walkthrough(
                            title: appInfo.vastlopen,
                            content: appInfo.vastlopenText,
                            //  imageIcon: Icons.verified_user,
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
                                      color: AppTheme.colors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                              onPressed: () => lastPage
                                  ?
                              toHome()
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
      ),
      ])),
    );
  }

  toHome() {
    Navigator.of(context).pop;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => Wrapper()));
  }
}
