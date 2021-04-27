import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_buble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('messtime')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final doc = snapshot.data.docs;
          final user = FirebaseAuth.instance.currentUser.uid;
          return ListView.builder(
              itemCount: doc.length,
              itemBuilder: (ctx, index) => MessageBubble(
                    doc[index]['username'],
                    doc[index]['text'],
                    doc[index]['userid'] == user,
                    doc[index]['userimage'],
                    key: ValueKey(doc[index].id),
                  )

              //     Container(
              //   padding: EdgeInsets.all(10),
              //   child: Text(doc[index]['text']))
              );
        });
  }
}
