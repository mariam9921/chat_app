import 'dart:io';

import 'package:chat/widget/user_image_packer.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function({
    required String email,
    required String userName,
    required String password,
     File? userImage,
    required bool isLogin,
    required BuildContext cxt,
  }) submitFn;
  final bool showSbener;

  // ignore: use_key_in_widget_constructors
  const AuthForm(this.submitFn, this.showSbener);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  String _email = '';
  String _userName = '';
  String _password = '';
  File? _userImage;
  final _formKey = GlobalKey<FormState>();
  void _pickImage(File? pickedImage) {
    _userImage = pickedImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Pleasepick Image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid != null) {
      _formKey.currentState!.save();
      widget.submitFn(
        email: _email.trim(),
        isLogin: _isLogin,
        password: _password.trim(),
        userName: _userName.trim(),
        userImage: _userImage,
        cxt: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePacker(_pickImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please Enter a valid email';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'email adreess',
                    ),
                    onSaved: (value) => _email = value!,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      key: const ValueKey('userName'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'User name should be grater than 7 letters';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'user name',
                      ),
                      onSaved: (value) => _userName = value!,
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Please Enter apassword grater than 7 letters';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'password',
                    ),
                    onSaved: (value) => _password = value!,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.showSbener) const CircularProgressIndicator(),
                  if (!widget.showSbener)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'login' : 'signUp'),
                    ),
                  if (!widget.showSbener)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                          _isLogin ? 'Create New account' : 'You have account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
