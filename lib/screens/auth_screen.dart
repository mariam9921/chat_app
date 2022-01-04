import 'dart:io';
import 'package:flutter/material.dart';
import '../widget/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void _submitUser({
    required String email,
    required String userName,
    required String password,
    required isLogin,
    File? userImage,
    required BuildContext cxt,
  }) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin == true) {
        authResult = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg');
        await ref.putFile(userImage!).whenComplete(() => null);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set(
          {
            'userName': userName,
            'email': email,
             'image_url':url,
          },
        );
      }
    } catch (error) {
      var message = 'An error occurred, Please check your credentials';

      message = error.toString();
      ScaffoldMessenger.of(cxt).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(
        _submitUser,
        _isLoading,
      ),
    );
  }
}
