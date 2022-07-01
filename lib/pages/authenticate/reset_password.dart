import 'package:ambu/services/auth.dart';
import 'package:ambu/shared/constants.dart';
import 'package:ambu/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:ambu/pages/wrapper.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';


class resetPassword extends StatefulWidget {
  resetPassword();

  @override
  _resetPasswordState createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';

  @override
  Widget build(BuildContext context) {

    return loading
        ? Loading()
        : Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppTheme.colors.primaryColor,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Wachtwoord herstellen',
            style: TextStyle(
                color: AppTheme.colors.primaryColor, fontSize: 18)),
        // actions: <Widget>[
        //   FlatButton.icon(
        //     icon: Icon(Icons.person, color: AppTheme.colors.primaryColor),
        //     label: Text('Registreer',
        //         style: TextStyle(color: AppTheme.colors.primaryColor)),
        //     onPressed: () => widget.toggleView(),
        //   ),
        // ],
      ),

      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(50, 50,50,0),
                  child: Text('Vul hieronder je e-mailadres in',textAlign: TextAlign.center, style: TextStyle(color: AppTheme.colors.textColor,fontSize: 17),)
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                        textInputDecoration.copyWith(hintText: 'email'),
                        validator: (val) =>
                        val!.isEmpty ? 'Voer een e-mailadres in' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: AppTheme.colors.accentColor,),
                          child: Text(
                            'Wachtwoord herstellen',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            // if (_formKey.currentState!.validate()) {
                            //   setState(() => loading = true);
                             await _auth.resetPassword(email: email, context:context);
                            //   if (result == null) {
                            //     setState(() {
                            //       loading = false;
                            //       error =
                            //       'Voer een geldig e-mailadres in';
                            //     });
                            //   }
                            //   else{
                            //     error = 'Een wachtwoord reset link is opgestuurd naar $email';
                            //   }
                            // }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),

                    ],
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
