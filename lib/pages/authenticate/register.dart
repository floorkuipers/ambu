import 'package:ambu/services/auth.dart';
import 'package:ambu/shared/constants.dart';
import 'package:ambu/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String nameAnon = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Image.asset('images/app_logo.png'),
                onPressed: () {},
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text('Registeren',
                  style: TextStyle(
                      color: AppTheme.colors.primaryColor, fontSize: 18)),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: AppTheme.colors.primaryColor),
                  label: Text(
                    'Inloggen',
                    style: TextStyle(color: AppTheme.colors.primaryColor),
                  ),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Scrollbar(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                        child: Column(children: [
                          Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Voornaam'),
                                  validator: (val) => val!.isEmpty
                                      ? 'Voer een voornaam in'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => name = val);
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'E-mail'),
                                  validator: (val) => val!.isEmpty
                                      ? 'Voer een e-mailadres in'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Wachtwoord'),
                                  obscureText: true,
                                  validator: (val) => val!.length < 6
                                      ? 'Het wachtwoord moet minimaal 6 karakters bevatten'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                                SizedBox(height: 20.0),
                                RaisedButton(
                                    color: AppTheme.colors.accentColor,
                                    child: Text(
                                      'Registreer',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .registerWithEmailAndPassword(
                                                email, password, name);
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            error =
                                                'Voer een geldig e-mail adres in';
                                          });
                                        }
                                      }
                                    }),
                                SizedBox(height: 12.0),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
                                ),
                              ])),
                          Form(
                            key: _formKey2,
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Anoniem inloggen',
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Text(
                                    'Je kunt ook inloggen zonder e-mailadres. \nLet op: Als je uitlogt in de app, ben je je gegevens en voortgang kwijt.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppTheme.colors.textColor,
                                        fontSize: 15)),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Voornaam'),
                                  validator: (val) => val!.isEmpty
                                      ? 'Voer een voornaam in'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => nameAnon = val);
                                  },
                                ),
                                SizedBox(height: 20.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppTheme
                                        .colors.accentColor, // Background color
                                  ),
                                  child: Text('Anoniem inloggen'),
                                  onPressed: () async {
                                    if (_formKey2.currentState!.validate()) {
                                      setState(() => loading = true);
                                      dynamic result =
                                          await _auth.signInAnon(nameAnon);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error = 'Inloggen niet gelukt';
                                        });
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ])))));
  }
}

class userType {
  static String type = '';
}
