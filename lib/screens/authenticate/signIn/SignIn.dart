import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_app_with_firebase/screens/authenticate/Register.dart';
import 'package:my_flutter_app_with_firebase/screens/authenticate/signIn/SignIn_Provider.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';
import 'package:my_flutter_app_with_firebase/screens/authenticate/Email.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String googleLogo = "assets/svg/Google_Logo.svg";
    final Widget googleSvgIcon = SvgPicture.asset(
      googleLogo,
      semanticsLabel: "Google G Logo",
    );
    SignInProvider _auth = SignInProvider();
    return Scaffold(
      body: Container(
        color: bodyBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Sign In or Register",
                style: textColor.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  color: buttonColor,
                  child: FlatButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Email()));
                      },
                      icon: Icon(Icons.email),
                      label: Text(
                        "Email and password",
                        style: textColor,
                      ))),
              SizedBox(
                height: 20,
              ),
              Container(
                  color: buttonColor,
                  child: FlatButton.icon(
                      onPressed: () {
                        _auth.authWithGoogle();
                      },
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: googleSvgIcon,
                      ),
                      label: Text(
                        "Google",
                        style: textColor,
                      ))),
              SizedBox(
                height: 20,
              ),
              Container(
                  color: buttonColor,
                  child: FlatButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      icon: Icon(Icons.create),
                      label: Text(
                        "Register",
                        style: textColor,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
