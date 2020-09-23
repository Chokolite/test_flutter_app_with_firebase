import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app_with_firebase/services/DatabaseShopService.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  String name;
  String model;
  String color;
  File image;
  String _result;

  bool _imageChoosed = false;



  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TextFormField(
            decoration: textInputDecoration.copyWith(labelText: "name"),
            onChanged: (val) => name = val,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: textInputDecoration.copyWith(labelText: "model"),
            onChanged: (val) => model = val,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: textInputDecoration.copyWith(labelText: "color"),
            onChanged: (val) => color = val,
          ),
          SizedBox(height: 10),
          RaisedButton.icon(
            icon: Icon(Icons.image, color: _imageChoosed? Colors.green : Colors.grey,),
            label: Text("add image"),
            onPressed: () async{

              image = File((await ImagePicker().getImage(source: ImageSource.gallery)).path);

              setState(() {
                _imageChoosed = true;
              });
            },
          ),
          SizedBox(height: 30),
          RaisedButton(
            child: Text("upload item"),
            onPressed: () async {
              final bool uploadResult = await DatabaseShopService().addItem(name, model, color, image);
              if(uploadResult !=null){
               setState((){
                 _result = "success";
               });
              }else{
                setState((){
                  _result = "error";
                });
              }
              },
          ),
          _result == null? Text("wait for sending") : Text("$_result", style: TextStyle(color: Colors.green),),
        ],
      );
  }
}
