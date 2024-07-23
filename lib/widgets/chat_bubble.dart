import 'package:flutter/material.dart';
import 'package:pingpong/constants.dart';
import 'package:pingpong/models/message.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.message});

  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
            bottomLeft: Radius.zero,
          ),
        ),
        padding: EdgeInsets.only(left: 18,top: 24, bottom: 24, right: 18),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          message.message,
          style: TextStyle(
            fontFamily: kFont,
            color: Colors.white,
            fontWeight: FontWeight.bold,fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({super.key, required this.message});

  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.zero,
          ),
        ),
        padding: EdgeInsets.only(left: 18,top: 24, bottom: 24, right: 18),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          message.message,
          style: TextStyle(
            fontFamily: kFont,
            color: Colors.white,
            fontWeight: FontWeight.bold,fontSize: 14,
          ),
        ),
      ),
    );
  }
}