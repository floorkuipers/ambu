import 'package:ambu/services/auth.dart';
import 'package:ambu/shared/constants.dart';
import 'package:ambu/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';
import 'package:ambu/pages/wrapper.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Image.asset('images/app_logo.png'),
                onPressed: () { },
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text('Inloggen',
                  style: TextStyle(
                      color: AppTheme.colors.primaryColor, fontSize: 18)),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: AppTheme.colors.primaryColor),
                  label: Text('Registreer',
                      style: TextStyle(color: AppTheme.colors.primaryColor)),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),

            body: Scrollbar(
              child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 50,50,0),
                      child: Text('Bedankt voor het downloaden van deze app! \n\nHeb je al een account? Dan kun je hieronder inloggen',textAlign: TextAlign.center, style: TextStyle(color: AppTheme.colors.textColor,fontSize: 17),)
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
                            TextFormField(
                              obscureText: true,
                              decoration:
                              textInputDecoration.copyWith(hintText: 'wachtwoord'),
                              validator: (val) => val!.length < 6
                                  ? 'Het wachtwoord moet minimaal 6 karakters bevatten'
                                  : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: AppTheme.colors.accentColor,),
                                child: Text(
                                  'Inloggen',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                        'Kon niet inloggen met deze inloggegevens';
                                      });
                                    }

                                  }
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
