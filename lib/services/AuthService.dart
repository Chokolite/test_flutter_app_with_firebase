import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app_with_firebase/model/UserData.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  get currentUserUid async{
    User user = _auth.currentUser;
    return user.uid;
  }

  _uploadAvatar(File image, String uid) async {
    String imageLink;
    FirebaseStorage fs = FirebaseStorage.instance;
    StorageReference sr = fs.ref();
    StorageReference avatarsFolder = sr.child("avatars").child(uid);

    await avatarsFolder.putFile(image).onComplete.then((storageTask) async {
      String link = await storageTask.ref.getDownloadURL();
      imageLink = link;
    });
    return imageLink;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User _user = result.user;
      return _userFromFirebaseUser(_user);
    } catch (e) {
      print("Sign in with email and password error: $e");
      return null;
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User user = authResult.user;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get()
          .then((doc) => {
                if (!doc.exists)
                  {
                    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
                      "uid": user.uid,
                      "name": user.displayName,
                      "imageLink": user.photoURL,
                    })
                  }
              });

      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Sing in with Google error: $e");
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      {String email, String password, String name, File image}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = credential.user;
      String imageLink = "";
      if(image != null){
        imageLink = await _uploadAvatar(image, user.uid);
      }

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "name": name,
        "imageLink": imageLink,
      });

      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Registration with email and password error: $e");
      return null;
    }
  }

   signOut() async {
    try {
       _googleSignIn.disconnect();
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
