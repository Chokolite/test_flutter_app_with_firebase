import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_with_firebase/screens/messenger/chat/ChatTile.dart';
import 'package:my_flutter_app_with_firebase/screens/messenger/chat/Chat_Provider.dart';
import 'package:my_flutter_app_with_firebase/shared/Constants.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app_with_firebase/model/Message.dart';
import 'package:my_flutter_app_with_firebase/model/UserData.dart';
import 'package:my_flutter_app_with_firebase/services/DatabaseMessengerService.dart';
import 'package:my_flutter_app_with_firebase/shared/Loading.dart';

class Chat extends StatefulWidget {
  final String myId;
  final UserData user;
  final String chatId;

  Chat({this.myId, this.user, this.chatId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final DatabaseMessengerService _db = DatabaseMessengerService();
  String text;

  @override
  Widget build(BuildContext context) {
    String _chatId = _db.generateChatId(widget.myId, widget.user.uid);

    return FutureProvider<List<Message>>.value(
        value: DatabaseMessengerService(chatId: _chatId).messages,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.user.name}"),
            centerTitle: true,
          ),
          body: Container(
              alignment: AlignmentDirectional.bottomEnd,
              child: Column(
                children: [
                  Expanded(child: Consumer<List<Message>>(
                      builder: (context, List<Message> message, _) {
                    return message != null
                        ? ListView.builder(
                            itemCount: message.length,
                            itemBuilder: (context, index) {
                              return message != null
                                  ? ChatTile(
                                      sendByMe: widget.myId,
                                      message: message[index],
                                      chatId: _chatId,
                                    )
                                  : Loading(); //Text("Message is null");
                            })
                        : Loading(); //Text("stream is null");
                  })),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<ChatProvider>()
                              .fromGallery(_chatId, widget.myId);
                        },
                        icon: Icon(Icons.image),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<ChatProvider>()
                              .fromCamera(_chatId, widget.myId);
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: textInputDecoration,
                          controller:
                              context.watch<ChatProvider>().getController,
                          onChanged: (val) =>
                              context.read<ChatProvider>().changeText(val),
                          // cp.changeText(val);
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<ChatProvider>()
                              .send(_chatId, widget.myId);
                        },
                        icon: Icon(
                          Icons.send,
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
