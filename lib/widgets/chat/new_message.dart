import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    //send message logic
    final user =  FirebaseAuth.instance.currentUser.uid;
    final userdata =
        await FirebaseFirestore.instance.collection('users').doc(user).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'messtime': Timestamp.now(),
      'username': userdata['username'],
      'userid': user,
      'userimage':userdata['image_url']

    });

    _controller.clear();
    setState(() {
      _enteredMessage='';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter a message'),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          ),
        ),
        IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.isEmpty ? null : _sendMessage)
      ],
    );
  }
}
