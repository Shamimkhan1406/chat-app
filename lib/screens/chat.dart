import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    print(token);
  }
  @override
  void initState() {
    super.initState();
    
    setupPushNotifications();
    // Optionally, you can add any initialization code here.
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [IconButton(onPressed: () {
          FirebaseAuth.instance.signOut();
        }, icon: Icon(Icons.exit_to_app))],
      ),
      body: Column(
        children: [
          Expanded(child: const ChatMessages()),
          const NewMessage(),
        ],
      ),
    );
  }
}
