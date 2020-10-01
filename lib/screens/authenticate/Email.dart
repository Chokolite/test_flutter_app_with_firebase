import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/services/AuthService.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';

class Email extends StatefulWidget {
  final Function switchView;

  Email({this.switchView});

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final AuthService _auth = AuthService();
  final GlobalKey _formKey = GlobalKey<FormState>();

  String email = " ";
  String password = " ";
  String _error = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In", style: textColor,),
        elevation: 0.0,
      ),
      body: Container(
        color: bodyBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Color(0xFFffdbc5), fontWeight: FontWeight.w300),
                decoration: textInputDecoration.copyWith(hintText: "Email",),
                onChanged: (val) => email = val,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: TextStyle(color: Color(0xFFffdbc5), fontWeight: FontWeight.w300),
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                onChanged: (val) => password = val,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Sign in", style: textColor,),
                onPressed: () async {
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      _error = "Wrong password or email";
                    });
                  }
                },
                color: buttonColor,
              ),
              SizedBox(height: 20.0),
              Text(
                _error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
