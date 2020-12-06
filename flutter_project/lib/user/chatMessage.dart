import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _name ="Mary";

class ChatMessage extends StatelessWidget {
  final String text;

  ChatMessage({this.text});
  @override
  Widget build(BuildContext context){
    return new Container(
              margin: const EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: new CircleAvatar(
                      child: new Text(_name[0]),
                    )
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(_name[0], style: Theme.of(context).textTheme.subtitle1),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(text),
                      )
                    ],
                  ), 
                ],
                ),
              );
  }
  
}