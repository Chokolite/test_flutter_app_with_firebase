import 'package:my_flutter_app_with_firebase/services/AuthService.dart';

class SignInProvider{
  AuthService auth = AuthService();

  authWithGoogle(){
    return auth.signInWithGoogle();
  }
}