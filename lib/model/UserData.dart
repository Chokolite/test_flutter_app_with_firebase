import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  final String uid;
  final String name;
  final String imageLink;

  UserData({this.uid, this.name, this.imageLink});

  factory UserData.fromFirebase(DocumentSnapshot snapshot) => UserData(
    uid: snapshot.data()["uid"],
    name: snapshot.data()["name"],
    imageLink: snapshot.data()["imageLink"],
  );
}