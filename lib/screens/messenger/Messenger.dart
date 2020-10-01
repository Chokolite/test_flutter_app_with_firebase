import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/model/UserData.dart';
import 'package:my_flutter_app_with_firebase/screens/messenger/chat/Chat.dart';
import 'package:my_flutter_app_with_firebase/screens/messenger/chat/Chat_Provider.dart';
import 'package:my_flutter_app_with_firebase/services/DatabaseMessengerService.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';
import 'package:my_flutter_app_with_firebase/shared/Loading.dart';
import 'package:provider/provider.dart';

class Messenger extends StatefulWidget {
  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  @override
  Widget build(BuildContext context) {
    final DatabaseMessengerService _db = DatabaseMessengerService();
    return Scaffold(
      appBar: AppBar(
        title: Text("list of users", style: textColor,),
        centerTitle: true,
      ),
      body: Container(
        color: bodyBackgroundColor,
        child: Consumer<List<UserData>>(
            builder: (context, List<UserData> users, _) {
          return users != null? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Card(
                    color: buttonColor,
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child:
                        Consumer(builder: (context, UserData _currentUser, _) {
                      return ListTile(
                        onTap: () {
                          _db.createChat(_currentUser.uid, users[index].uid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<ChatProvider>.value(
                                      value: ChatProvider(),
                                      child: Chat(
                                          myId: _currentUser.uid,
                                          user: users[index])),
                            ),
                          );
                        },
                        title: Text(users[index].name, style: textColor,),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(users[index].imageLink),
                        ),
                      );
                    }),
                  ),
                );
              }) : Loading();
        }),
      ),
    );
  }
}
