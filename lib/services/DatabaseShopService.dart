import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_flutter_app_with_firebase/model/Item.dart';

class DatabaseShopService {
  final String id;

  DatabaseShopService({this.id});

  final CollectionReference _shop =
      FirebaseFirestore.instance.collection("shop");

  Future<List<Item>>get items async {
    return await _shop.get().then((snapshot) => snapshot.docs.map((e) => Item.fromFirebase(e)).toList());
  }

  _uploadImage(File image, String name) async{
    String imageLink;
    FirebaseStorage _fs = FirebaseStorage.instance;
    StorageReference sr = _fs.ref();
    StorageReference itemImage = sr.child("itemImage").child(name);

    await itemImage.putFile(image).onComplete.then((storageTask) async{
      String image = await storageTask.ref.getDownloadURL();
      imageLink = image;
    });

    return imageLink;

  }
  addItem(String name, String model, String color, File image) async {
    try {
      String id = Random().hashCode.toString();
      String imageLink = await _uploadImage(image, id);
      await _shop.add({
        "id" : id,
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
