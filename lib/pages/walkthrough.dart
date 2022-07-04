import 'package:ambu/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Walkthrough extends StatefulWidget {
  final title;
  final content;
  final imageIcon;

  Walkthrough(
      {this.title,
        this.content,
        this.imageIcon
        });

  @override
  WalkthroughState createState() {
    return WalkthroughState();
  }
}

class WalkthroughState extends State<Walkthrough>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    animation.addListener(() => setState(() {}));

    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: Material(
        animationDuration: Duration(milliseconds: 500),
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Transform(
              transform:
              new Matrix4.translationValues(animation.value, 0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: new Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colors.primaryColor),
                ),
              ),
            ),
            new Transform(
              transform:
              new Matrix4.translationValues(animation.value, 0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 50),
                child: new Text(widget.content,
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: AppTheme.colors.textColor)),
              ),
            ),
            // new Icon(
            //   widget.imageIcon,
            //   size: 100.0,
            //   color: imagecolor,
            // )
          ],
        ),
      ),
    );
  }
}