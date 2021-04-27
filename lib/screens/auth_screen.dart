import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isloading = false;

  void _submitAuthForm(String email, String password, String username,
      File image, bool isLogin, BuildContext ctx) async {
    UserCredential _authResult;
    try {
      setState(() {
        isloading = true;
      });
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(_authResult.user.uid + '.jpg');
        await ref.putFile(image);
        final url = await ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(_authResult.user.uid)
            .set({
          'username': username,
          'password': password,
          'email': email,
          'image_url': url,
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = ' error accrued';
      if (e.code == 'weak-password') {
        message = ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        message = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(message), backgroundColor: Theme.of(ctx).errorColor));
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print('Email address or Password is invalid');
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, isloading),
    );
  }
}
