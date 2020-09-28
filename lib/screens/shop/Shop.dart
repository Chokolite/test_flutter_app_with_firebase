import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app_with_firebase/screens/shop/AddForm.dart';
import 'package:my_flutter_app_with_firebase/screens/shop/MyList.dart';
import 'package:my_flutter_app_with_firebase/model/UserData.dart';
import 'package:my_flutter_app_with_firebase/services/DatabaseMessengerService.dart';
import 'package:my_flutter_app_with_firebase/screens/messenger/Messenger.dart';
import 'package:my_flutter_app_with_firebase/services/AuthService.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  AuthService _auth = AuthService();
  bool isGridMode = false;


  void toggleState() {
    setState(() => isGridMode = !isGridMode);
  }

  @override
  Widget build(BuildContext context) {
    void _showAddPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: AddForm(),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _showAddPanel(),
            icon: Icon(Icons.add, color: iconColor,),
          ),
          IconButton(
            onPressed: () => toggleState(),
            icon: isGridMode ? Icon(Icons.grid_on, color: iconColor,) : Icon(Icons.list, color: iconColor,),
          ),
          FlatButton.icon(
            onPressed: () {
             _auth.signOut();
            },
            icon: Icon(Icons.person, color: iconColor,),
            label: Text("Log out"),
          ),
                  ],
        leading: IconButton(
          color: buttonColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  FutureProvider<List<UserData>>.value
                    (value: DatabaseMessengerService().userData,
                      child: Messenger()),
                )
            );
          },
          icon: Icon(Icons.chat, color: iconColor,),
        ),
        backgroundColor: appBarColor,
      ),
      body:Container(
        child: MyList(
          isGridMode: isGridMode,
        ),
      ),
    );
  }
}
