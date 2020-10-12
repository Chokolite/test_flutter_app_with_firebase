import 'package:cloud_firestore/cloud_firestore.dart';
class Item{
  String id;
  String name;
  String model;
  String color;
  String imageLink;

  Item({this.name, this.model, this.color, this.imageLink, this.id});

  factory Item.fromFirebase(DocumentSnapshot snapshot) => Item(
    id: snapshot.data()["id"] as String,
    name: snapshot.data()["name"] as String,
    model: snapshot.data()["model"] as String,
    color: snapshot.data()["color"] as String,
    imageLink: snapshot.data()["imageLink"] as String,
  );
}