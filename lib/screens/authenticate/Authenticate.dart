import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/screens/authenticate/Register.dart';
import 'package:my_flutter_app_with_firebase/screens/authenticate/SignIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;

  void switchView(){
    setState(() => signIn = !signIn);
  }
  @override
  Widget build(BuildContext context) {

    if(signIn == true){
      return SignIn(switchView: switchView);
    }else {
      return Register(switchView: switchView);
    }
  }
}
