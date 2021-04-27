import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageBubble extends StatelessWidget {
  final String username;
  final String message;
  final bool isMe;
  final Key key;
  final String userImage;

  MessageBubble(this.username, this.message, this.isMe, this.userImage,
      {this.key});

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isMe ? Colors.grey : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: isMe ? Radius.circular(14) : Radius.circular(0),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(14),
                  )),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Colors.white),
                  ),
                  Text(message,
                      style:
                          TextStyle(color: isMe ? Colors.black : Colors.white),
                      textAlign: isMe ? TextAlign.end : TextAlign.start),
                ],
              ),
            )
          ],
        ),
        Positioned(
            top: 22,
            left: !isMe ? 115 : null,
            right: isMe ? 115 : null,
            child: CircleAvatar(

              backgroundImage: NetworkImage(userImage),
              radius: 14,
            ))
      ],
    );
  }
}
