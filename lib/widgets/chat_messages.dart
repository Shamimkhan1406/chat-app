import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('chats')
              .orderBy('createdAt', descending: false)
              .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Messages Found.'));
        }
        if (chatSnapshot.hasError) {
          return const Center(child: Text('Something Went Wrong.'));
        }
        final loadedMessages = chatSnapshot.data!.docs;
        return ListView.builder(
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, idx) {
            return Text(loadedMessages[idx].data()['text']);
          },
        );
      },
    );
  }
}
