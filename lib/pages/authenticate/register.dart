import 'package:ambu/services/auth.dart';
import 'package:ambu/shared/constants.dart';
import 'package:ambu/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ambu/theme/app_theme.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ required this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Registeren', style: TextStyle(color: AppTheme.colors.accentColor, fontSize: 18)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: AppTheme.colors.accentColor),
            label: Text(
                'Inloggen',
              style: TextStyle(color: AppTheme.colors.accentColor),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Voornaam'),
                validator: (val) => val!.isEmpty ? 'Voer een voornaam in' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
                validator: (val) => val!.isEmpty ? 'Voer een e-mailadres in' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Wachtwoord'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Het wachtwoord moet minimaal 6 karakters bevatten' : null,
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
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Voer een geldig e-mail adres in';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}