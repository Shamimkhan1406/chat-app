import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('chats')
              .orderBy('createdAt', descending: true)
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
          padding: EdgeInsets.only(bottom: 40, left: 15, right: 15),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, idx) {
            //return Text(loadedMessages[idx].data()['text']);
            final chatMessage = loadedMessages[idx].data();
            final nextChatMessage =
                idx + 1 < loadedMessages.length
                    ? loadedMessages[idx + 1].data()
                    : null;

            final currentMsgUserId = chatMessage['userId'];
            final nextMsgUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = currentMsgUserId == nextMsgUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMsgUserId,
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMsgUserId,
              );
            }
          },
        );
      },
    );
  }
}
