import 'package:flutter/cupertino.dart';
import 'package:my_flutter_app_with_firebase/services/AuthService.dart';

class SignInProvider extends ChangeNotifier{
  AuthService auth = AuthService();

  authWithGoogle(){
    notifyListeners();
    return auth.signInWithGoogle();
  }
}