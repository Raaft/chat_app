import 'dart:io';

import 'package:firebase/widgets/pickers/new_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      File image, bool isLogin, BuildContext ctx) submitfu;
  final bool isloading;

  const AuthForm(this.submitfu, this.isloading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = new GlobalKey<FormState>();
  String _password = ' ';
  String _email = ' ';
  String _username = ' ';
  bool _islogin = true;
  File userImageFile;

  void _pickImage(File _pickImage) async {
    userImageFile = _pickImage;
  }

  void _submit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!_islogin && userImageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please Select Image'),
          backgroundColor: Theme.of(context).errorColor));
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget.submitfu(_email.trim(), _password.trim(), _username.trim(),
          userImageFile, _islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_islogin) UserImagePiker(_pickImage),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return 'Pleas Enter A Valid Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (val) => _email = val,
                ),
                if (!_islogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 4) {
                        return 'Pleas Enter at least 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                    onSaved: (val) => _username = val,
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val) {
                    if (val.isEmpty || val.length < 7) {
                      return 'Pleas Enter at least 7 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  onSaved: (val) => _password = val,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                if (widget.isloading) CircularProgressIndicator(),
                if (!widget.isloading)
                  RaisedButton(
                      // color: Theme.of(context).primaryColor,
                      child: Text(_islogin ? 'Login' : 'Sign up'),
                      onPressed: _submit),
                if (!widget.isloading)
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(_islogin
                          ? 'Create a new account'
                          : 'Already have an account')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
