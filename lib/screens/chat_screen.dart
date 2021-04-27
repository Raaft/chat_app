import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/widgets/chat/messages.dart';
import 'package:firebase/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 2),
                    Text('Log out')
                  ],
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemDefinder) {
              if (itemDefinder == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            dropdownColor: Colors.white.withOpacity(.9),
          )
        ],
      ),
      body: Container(

        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
