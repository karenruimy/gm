import 'package:cloud_firestore/cloud_firestore.dart';

import '../cubit/chat_cubit.dart';

class ChatRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future sendText(MessageInputModel messageInput) async {
    await _firestore
        .collection('chats')
        .doc(messageInput.chatNodeId)
        .collection('messages')
        .add({
      'senderId': messageInput.senderId,
      'receiverId': messageInput.receiverId,
      'message': messageInput.message,
      'type': 'text',
      'status': messageInput.status,
      'time': DateTime.now(),
    }).then(
      (value) =>
          _firestore.collection('chats').doc(messageInput.chatNodeId).set(
        {
          'senderId': messageInput.senderId,
          'receiverId': messageInput.receiverId,
          'senderName': messageInput.senderName,
          'receiverName': messageInput.receiverName,
          'senderProfile': messageInput.senderProfile,
          'receiverProfile': messageInput.receiverProfile,
          'last_msg': messageInput.message,
          'msgType': 'text',
          'unreadCount': messageInput.unreadCount,
          'time': DateTime.now(),
        },
      ),
    );
  }
}
