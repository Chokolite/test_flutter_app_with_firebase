import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app_with_firebase/services/AuthService.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';

class SignIn extends StatefulWidget {
  final Function switchView;
  SignIn({this.switchView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 final AuthService _auth = AuthService();
 final GlobalKey _formKey = GlobalKey<FormState>();

  String email = " ";
  String password = " ";
  String _error = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () {widget.switchView();},
              icon: Icon(Icons.person),
              label: Text("Register"),
          ),
          FlatButton.icon(onPressed: (){
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          }, icon: Icon(Icons.exit_to_app), label: Text("Exit"),),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                onChanged: (val) => email = val,
              ),
            SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                onChanged: (val) => password = val,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Sign in"),
                onPressed: () async {
                dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                if(result == null){
                  setState(() {
                        _error = "Wrong password or email";
                  });
                }
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Sign in with Google"),
                onPressed: () {
                  _auth.signInWithGoogle();
                },
              ),
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
