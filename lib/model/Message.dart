import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String text;
  String sendBy;
  String time;
  String imageLink;

  Message({this.text, this.sendBy, this.time, this.imageLink});

  factory Message.fromFirebase(DocumentSnapshot snapshot) => Message(
    text: snapshot.data()["text"] as String ?? "",
    sendBy: snapshot.data()["sendBy"] as String,
    time:  snapshot.data()["time"].toString(),
    imageLink: snapshot.data()["imageLink"] as String ?? "",
  );
}