import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app_with_firebase/services/AuthService.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';

class Register extends StatefulWidget {
  final Function switchView;

  Register({this.switchView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String name = "";
  String _error = "";
  String imageLink = "";

  bool _picked = false;

  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Register",
          style: textColor,
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: bodyBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                style: TextStyle(
                    color: Color(0xFFffdbc5), fontWeight: FontWeight.w300),
                validator: (val) => val.isEmpty ? "Enter the email" : null,
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                onChanged: (val) => email = val,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: TextStyle(
                    color: Color(0xFFffdbc5), fontWeight: FontWeight.w300),
                validator: (val) =>
                    val.length < 6 ? "Password less than 6 chars" : null,
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: TextStyle(
                    color: Color(0xFFffdbc5), fontWeight: FontWeight.w300),
                validator: (val) => val.isEmpty ? "Enter the name" : null,
                decoration: textInputDecoration.copyWith(hintText: "Name"),
                onChanged: (val) => name = val,
              ),
              SizedBox(height: 20.0),
              FloatingActionButton(
                elevation: 0,
                backgroundColor: _picked ? buttonColor : Colors.grey,
                child: Icon(
                  Icons.image,
                  color: _picked ? Colors.green : Colors.blueGrey,
                ),
                onPressed: () async {
                  image = File((await ImagePicker()
                          .getImage(source: ImageSource.gallery))
                      .path);
                  if (image != null) {
                    setState(() => _picked = true);
                  }
                },
              ),
              SizedBox(height: 20.0),
              Expanded(
                  flex: 1, child: image == null ? Text("") : Image.file(image)),
              RaisedButton(
                color: buttonColor,
                child: Text(
                  "Register",
                  style: textColor,
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email: email,
                        password: password,
                        name: name,
                        image: image);
                    if (result == null) {
                      _error = "please supply a valid data";
                    } else{
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(_error, style: TextStyle(color: Colors.red, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
