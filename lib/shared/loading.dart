import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:IVEA/theme/app_theme.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.all(55),
              child: SpinKitChasingDots(
                color: AppTheme.colors.primaryColor,
                size: 50.0,
              ),
            ),
            //Text("Aan het laden..."),
          ]),
        ));
  }
}
