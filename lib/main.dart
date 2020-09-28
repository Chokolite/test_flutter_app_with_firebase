import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/screens/Wrapper.dart';
import 'package:my_flutter_app_with_firebase/services/AuthService.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';
import 'package:provider/provider.dart';

import 'model/UserData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthService().user,
      child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: appBarColor,
            ),
          ),
          home: Wrapper()),
    );
  }
}
