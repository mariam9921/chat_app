import 'package:chat/widget/chat/new_message.dart';

import '../widget/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat app'),
        
        actions: [
          DropdownButton(
            underline: Container(),
            iconSize: 30,
            icon: const Icon(
              Icons.more_vert
              
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ],
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: 
         Column(
          children: [
            const Expanded(
              child: Message(),
            ),
            NewMessage(),
          ],
        ),
     
    );
  }
}



