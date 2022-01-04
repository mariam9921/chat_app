import 'package:chat/widget/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(

       future: Future.value(FirebaseAuth.instance.currentUser),   
       builder: (cxt,futureSnapShot){
      if(futureSnapShot.connectionState==ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createAt',
            descending: true,
          )
          .snapshots(),
      builder: (cxt, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocuments = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocuments.length,
          itemBuilder: (context, index) => MessageBuble(
            chatDocuments[index]['text'],
            chatDocuments[index]['userID']==futureSnapShot.data!.uid,
            chatDocuments[index]['userName'],
            chatDocuments[index]['userImage'],
            keyList: ValueKey(chatDocuments[index].id),
            
          ),
        );
      },
    );
    });
  }
}
