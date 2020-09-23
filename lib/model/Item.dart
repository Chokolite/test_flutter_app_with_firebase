import 'package:cloud_firestore/cloud_firestore.dart';
class Item{
  String name;
  String model;
  String color;
  String imageLink;

  Item({this.name, this.model, this.color, this.imageLink});

  factory Item.fromFirebase(DocumentSnapshot snapshot) => Item(
    name: snapshot.data()["name"] as String,
    model: snapshot.data()["model"] as String,
    color: snapshot.data()["color"] as String,
    imageLink: snapshot.data()["imageLink"] as String,
  );
}