import 'package:chatapp/widgets/chatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticateduserid = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true
                //setting true to view latest message at the bottom always
                )
            .snapshots(),
        builder: (ctx, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return const Center(child: Text('No message found'));
          }
          if (chatSnapshots.hasError) {
            return const Center(child: Text('Something went wrong...'));
          }
          final messages = chatSnapshots.data!.docs;
          return ListView.builder(
            itemCount: messages.length,
            reverse: true,
            //messages will be pushed to bottom
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            itemBuilder: (context, index) {
              final chatmessage = messages[index].data();
              final nextmessage = index + 1 < messages.length
                  ? messages[index + 1].data()
                  : null;
              final currentmsguserid = chatmessage['userid'];
              final nextmessageuserid =
                  nextmessage != null ? nextmessage['userid'] : null;
              final iscurrentusersame = currentmsguserid == nextmessageuserid;
              if (iscurrentusersame) {
                return MessageBubble.next(
                    message: chatmessage['message'],
                    isMe: authenticateduserid.uid == currentmsguserid);
              } else {
                return MessageBubble.first(
                    username: chatmessage['name'],
                    message: chatmessage['message'],
                    isMe: authenticateduserid.uid == currentmsguserid);
              }
          },
       );
      },
    );
  }
}
