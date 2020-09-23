import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app_with_firebase/services/DatabaseMessengerService.dart';

class ChatProvider extends ChangeNotifier {

 final DatabaseMessengerService _db = DatabaseMessengerService();
  String _text;
 TextEditingController _controller = TextEditingController();


 void changeText(String newText){
    _text = newText;
    notifyListeners();
  }

 String getChatId(String myId, String userId){
    return _db.generateChatId(myId, userId);
  }
  get getText => _text;


 fromGallery(String chatId, String myId) async{
   File image = File((await ImagePicker()
       .getImage(source: ImageSource.gallery))
       .path);
   await _db.sendImage(image: image, sendBy: myId, chatId: chatId);
   notifyListeners();
 }
 fromCamera(String chatId, String myId) async{
   File image = File((await ImagePicker()
       .getImage(source: ImageSource.camera))
       .path);
   await _db.sendImage(image: image, sendBy: myId, chatId: chatId);
   notifyListeners();
 }

  send(String chatId, String myId) async{
    await _db.sendMessage(
      chatId: chatId,
      text: _text,
      sendBy: myId,
    );
    _controller.clear();
    notifyListeners();
  }

  get getController => _controller;


}