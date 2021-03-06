import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/model/UserData.dart';
import 'package:my_flutter_app_with_firebase/screens/authenticate/signIn/SignIn.dart';
import 'package:my_flutter_app_with_firebase/screens/authenticate/signIn/SignIn_Provider.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app_with_firebase/screens/shop/Shop.dart';
import 'package:my_flutter_app_with_firebase/services/DatabaseShopService.dart';
import 'package:my_flutter_app_with_firebase/model/Item.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

  return Consumer<UserData>(
    builder: (context, UserData _user, _) {
      if (_user == null) {
        return ChangeNotifierProvider.value(
            value: SignInProvider(),
            child: SignIn());
      } else {
        return FutureProvider<List<Item>>.value(
            value: DatabaseShopService().items,
            child: Shop()
        );
      }
    }
    );
  }
}
