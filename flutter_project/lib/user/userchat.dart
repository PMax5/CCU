import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/user.dart';
import 'package:flutter_complete_guide/models/concert.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';
import '../settings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/user/chatMessage.dart';

class UserChat extends StatefulWidget {
  UserChat({Key key}) : super(key: key);

  @override
  UserChatState createState() => UserChatState();
}
const String _name ="Mary";
class UserChatState extends State<UserChat> {
  final List<ChatMessage> _messages = <ChatMessage> [];
  ConcertService concertService = new ConcertService();
  final String text;
  final TextEditingController _textController = new TextEditingController();

  UserChatState({this.text});
  
  void _handleSubmitted(String text) {
    _textController.clear(); 
    ChatMessage message =new ChatMessage(
      text:text);
    setState(() {
      _messages.insert(0,message);
    });
  }


  Widget _textComposerWidget(){
    return new IconTheme(
      data: new IconThemeData(
        color: Color.fromRGBO(149, 0, 62, 1),
      ),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal:8.0),
        alignment: Alignment.bottomCenter,
        child:  new Row(
          children: [
            new Flexible(
              child: new TextField(
                //textAlignVertical: TextAlignVertical.bottom,
                decoration: new InputDecoration.collapsed(
                  hintText: "Message here..."
                ),
                controller: _textController,
                onSubmitted: _handleSubmitted, 
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send), 
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text("James Smith's Concert"),
              backgroundColor: projectSettings.mainColor,
          ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 360.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: new EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: new CircleAvatar(
                      child: new Text("I"),
                    )
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text("Isabella", style: Theme.of(context).textTheme.subtitle1),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text("I love you, James!"),
                      )
                    ],
                  ), 
                ],
                ),
              ),
              Container(
              padding: new EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: new CircleAvatar(
                      child: new Text("J"),
                    )
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text("John", style: Theme.of(context).textTheme.subtitle1),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text("Amazing! Your voice is incredible!"),
                      )
                    ],
                  ), 
                ],
                ),
              ),
              Container(
              padding: new EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: new Image.asset('assets/images/mini_james.png'),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text("James", style: Theme.of(context).textTheme.subtitle1),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text("Thank you! I hope you loved my show!"),
                      )
                    ],
                  ), 
                ],
                ),
              ),
            //new ChatMessage(),
            // new Flexible(
            //   child: new ListView.builder(
            //     padding: new EdgeInsets.all(8.0),
            //     reverse: true,
            //     itemBuilder: (_,int index) => _messages[index],
            //     itemCount: _messages.length,
                
            //   ),),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _textComposerWidget(),       
            )
          ],
        ),
      ),
      ),
    );
  }
}


