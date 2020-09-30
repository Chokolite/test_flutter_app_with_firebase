import 'package:flutter/material.dart';

 const textInputDecoration = InputDecoration(
   filled: true,
   enabledBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.grey, width: 2.0)
   ),
   focusedBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)
   ),
   hintStyle: textColor,
 );
 
 const textColor =  TextStyle(color: Color(0xFFffdbc5), fontWeight: FontWeight.w300,);
 const buttonColor = Color(0xFFcf1b1b);//Color.fromRGBO(144, 233, 150, 1.0);
 const appBarColor = Color(0xFFcf1b1b);//Color.fromRGBO(65, 211, 75, 1.0);
 const iconColor = Color(0xFF423144);//Color.fromRGBO(21, 137, 29, 1.0);
 const bodyBackgroundColor = Color(0xFF900d0d);//Color.fromRGBO(255, 219, 197, 1.0);