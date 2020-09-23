import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/model/Message.dart';

class ChatTile extends StatelessWidget {
  final Message message;
  final String sendByMe;
  final String chatId;

  ChatTile({this.sendByMe, this.message, this.chatId});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: message.sendBy == sendByMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: message.sendBy == sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          color: message.sendBy == sendByMe ? Colors.blue : Colors.grey,
          borderRadius: message.sendBy == sendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
        ),
        child: Column(children:[
        Text("${message.text}"),
          message.imageLink == null ? Text("") : Image.network(message.imageLink) ,
            ]),
      ),
    );
  }
}
