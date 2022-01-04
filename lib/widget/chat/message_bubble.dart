import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MessageBuble(this.message, this.isMe, this.userName, this.userImageUrl,
      { required this.keyList}) ;
  final String message;
  final String userName;
  final String userImageUrl;
  final bool isMe;
  final Key keyList;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Colors.grey[400]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
                bottomRight: isMe ? Radius.zero : const Radius.circular(15)),
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImageUrl),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
