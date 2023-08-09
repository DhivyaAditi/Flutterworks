import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var messagecontroller = TextEditingController();

  void sendMessage() async {
    final enteredmessage = messagecontroller.text;
    
    if (enteredmessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
     messagecontroller.clear();

    final user=FirebaseAuth.instance.currentUser!;
    final userdata=await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'message':enteredmessage,
      'userid':user.uid,
      'createdAt':Timestamp.now(),
      'name':userdata.data()!['name']
    }); 
  }


  @override
  void dispose() {
    messagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: messagecontroller,
            decoration: const InputDecoration(labelText: 'send message'),
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
          ),
          ),
          IconButton(
              onPressed:sendMessage,
              icon: Icon(Icons.send,
                  color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }
}
