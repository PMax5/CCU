import 'dart:async';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/concert.dart';
import 'package:flutter_complete_guide/models/user.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';

import '../settings.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({Key key}) : super(key: key);

  @override
  ChatRoomState createState() => ChatRoomState();

}

class ChatRoomState extends State<ChatRoom> {
  Settings projectSettings = new Settings();
  List<ChatMessage> chatMessages = new List<ChatMessage>();
  ConcertService _concertService = new ConcertService();
  User user;

  void addMessage(ChatUser user, String message) {
    chatMessages.add(new ChatMessage(
        text: message,
        user: user
    ));
  }

  Future<List<Message>> loadMessages(int concertId) async {
    try {
      List<Message> messages = await _concertService.getConcertMessages(concertId);
      chatMessages.clear();
      return messages;
    } catch(e) {
      print(e.toString());
    }
  }

  Future<void> sendMessage(int concertId, String text, User user) async {
    try {
      List<Message> messages = await _concertService.sendMessage(concertId, new Message(text, user));
      chatMessages.clear();
      insertMessages(messages);
    } catch(e) {
      print(e.toString());
    }
  }

  void insertMessages(List<Message> messages) {
    messages.forEach((message) {
      addMessage(ChatUser(
          name: message.author.name,
          uid: message.author.username,
          avatar: message.author.imagePath
      ), message.message);
    });
  }

  Widget createRoom(BuildContext context, ChannelArguments arguments) {
    //TODO: Add timer.
    loadMessages(arguments.channel.concertId).then((messages) {
      insertMessages(messages);
    });

    return DashChat(
        messages: chatMessages,
        inputCursorColor: projectSettings.mainColor,
        onSend: (message) {
          addMessage(message.user,
              message.text);
          sendMessage(arguments.channel.concertId, message.text, this.user);
        },
        messageDecorationBuilder: (message, isUser) {
          return BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: isUser ? projectSettings.mainColor : Color.fromRGBO(224, 224, 224, 1)
          );
        },
        user: ChatUser(
          name: user != null ? user.name : "John Doe",
          uid: user != null ? user.username : "someone",
          avatar: user != null ? user.imagePath : "https://cdn3.iconfinder.com/data/icons/general-user-interface/81/Profile-512.png",
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    ChannelArguments arguments = ModalRoute.of(context).settings.arguments;
    user = arguments.user;
    return Scaffold(
        appBar: AppBar(
          title: Text(arguments.channel.name),
          backgroundColor: projectSettings.mainColor,
        ),
        body: createRoom(context, arguments)
    );
  }
}
