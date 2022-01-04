import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: use_key_in_widget_constructors
class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredValue = '';
  final messageControler = TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    // ignore: await_only_futures
    final user = await FirebaseAuth.instance.currentUser;
    final userName = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredValue,
      'createAt': Timestamp.now(),
      'userID': user.uid,
      'userName': userName['userName'],
      'userImage': userName['image_url'],
    });
    _enteredValue = '';
    messageControler.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageControler,
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Message'),
              onChanged: (value) {
                setState(() {
                  _enteredValue = value.trim();
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredValue.isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
