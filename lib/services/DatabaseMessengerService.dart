import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_flutter_app_with_firebase/model/Message.dart';
import 'package:my_flutter_app_with_firebase/model/UserData.dart';

class DatabaseMessengerService {
  String uid;
  final String chatId;

  DatabaseMessengerService({this.chatId, this.uid});

  final CollectionReference _chat =
      FirebaseFirestore.instance.collection("chat");

  final CollectionReference _users =
      FirebaseFirestore.instance.collection("users");

  downloadAvatar(String uid) async {
    StorageReference avatarsFolder =
        FirebaseStorage.instance.ref().child("avatars");

    File avatar =
        File.fromRawPath(await avatarsFolder.child(uid).getDownloadURL());

    return avatar;
  }

  _uploadImage(File image) async {
    String imageLink;
    FirebaseStorage fs = FirebaseStorage.instance;
    StorageReference sr = fs.ref();
    StorageReference itemImage =
        sr.child("images").child(Random().hashCode.toString());

    await itemImage.putFile(image).onComplete.then((storageTask) async {
      String image = await storageTask.ref.getDownloadURL();
      imageLink = image;
    });

    return imageLink;
  }

  Future updateUserData(String uid, String name) async {
    return await _users.add({
      "uid": uid,
      "name": name,
    });
  }

  String generateChatId(String uid1, String uid2) {
    if (uid1.hashCode > uid2.hashCode) {
      return "${uid1}_$uid2".hashCode.toString();
    } else {
      return "${uid2}_$uid1".hashCode.toString();
    }
  }

  createChat(String myId, String userId) {
    final String chatId = generateChatId(myId, userId);
    return _chat.doc(chatId).collection("messages");
  }

  Future<void> sendMessage({String chatId, String text, String sendBy}) async {
    return await _chat.doc(chatId).collection("messages").add({
      "text": text,
      "sendBy": sendBy,
      "time": FieldValue.serverTimestamp(),
    });
  }

  sendImage({File image, String sendBy, String chatId}) async {
    String imageLink = await _uploadImage(image);
    await _chat.doc(chatId).collection('messages').add({
      "sendBy": sendBy,
      "time": FieldValue.serverTimestamp(),
      "imageLink": imageLink,
    });
  }

  List<Message> _messagesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Message(
        text: doc.data()["text"].toString() ?? "",
        sendBy: doc.data()["sendBy"].toString()?? "",
        time: doc.data()["time"].toString() ?? "",
        imageLink: doc.data()["imageLink"].toString() ?? "",
      );
    }).toList();
  }

  Stream<List<Message>> get messages {
    return _chat
        .doc(chatId)
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .map(_messagesListFromSnapshot);
  }

  Future<List<UserData>> get userData async {
    return await _users.get().then((snapshot) =>
        snapshot.docs.map((e) => UserData.fromFirebase(e)).toList());
  }
}
