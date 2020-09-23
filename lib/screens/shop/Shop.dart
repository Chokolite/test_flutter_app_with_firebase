import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => toggleState(),
            icon: isGridMode ? Icon(Icons.grid_on) : Icon(Icons.list),
          ),
          FlatButton.icon(
            onPressed: () {
             _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text("Log out"),
          ),
          FlatButton.icon(onPressed: (){
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          }, icon: Icon(Icons.exit_to_app), label: Text("Exit"),),
        ],
        leading: IconButton(
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
          icon: Icon(Icons.chat),
        ),
      ),
      body: Container(
        child: MyList(
          isGridMode: isGridMode,
        ),
      ),
    );
  }
}
