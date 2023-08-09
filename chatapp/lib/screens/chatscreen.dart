import 'package:chatapp/widgets/chatmessage.dart';
import 'package:chatapp/widgets/newmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
//  void setupnotifications() async{
//   final fcm= FirebaseMessaging.instance;
//   await fcm.requestPermission();
//   final token=await fcm.getToken();
//   print(token);
//  }
//   @override
//   void initState() {
//     super.initState();
//     setupnotifications();
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('chat'),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: Column(
          children: const [
            Expanded(child: ChatMessage()),
            NewMessage(),
          ],
        ));
  }
}
