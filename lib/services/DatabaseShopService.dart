import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_flutter_app_with_firebase/model/Item.dart';

class DatabaseShopService {
  final String id;

  DatabaseShopService({this.id});

  final CollectionReference _shop =
      FirebaseFirestore.instance.collection("shop");
  final FirebaseStorage fs = FirebaseStorage.instance;

  Future<List<Item>>get items async {
    return await _shop.get().then((snapshot) => snapshot.docs.map((e) => Item.fromFirebase(e)).toList());
  }

  _uploadImage(File image, String name) async{
    String imageLink;
    FirebaseStorage fs = FirebaseStorage.instance;
    StorageReference sr = fs.ref();
    StorageReference itemImage = sr.child("itemImage").child(name);

    await itemImage.putFile(image).onComplete.then((storageTask) async{
      String image = await storageTask.ref.getDownloadURL();
      imageLink = image;
    });

    return imageLink;

  }
  addItem(String name, String model, String color, File image) async {
    try {
      String imageLink = await _uploadImage(image, name);

      await _shop.add({
        "name": name,
        "model": model,
        "color": color,
        "imageLink": imageLink,
      });
      return true;
    } catch (e) {
      print("Error add item to database: $e");
      return false;
    }
  }
}