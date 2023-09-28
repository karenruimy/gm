import 'package:bloc/bloc.dart';
import 'package:goddessmembership/core/notifications/cloud_messaging_service.dart';
import 'package:meta/meta.dart';

import '../repo/chat_repo.dart';
import 'image_picker_cubit/image_picker_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.imagePickerCubit, this.chatRepository) : super(ChatInitial());

  ImagePickerCubit imagePickerCubit;
  ChatRepository chatRepository;

  Future sendTextMessage(MessageInputModel messageInput) async {
    print("Chat cubit ---- ${messageInput.isReceiverInChat}");
    chatRepository.sendText(messageInput).then(
      (value) async {
        print('fcm token :: ${messageInput.fcmToken}');
        if (!messageInput.isReceiverInChat) {
          await CloudMessagingService.sendNotification(
            messageInput.fcmToken,
            messageInput.senderName,
            messageInput.message,
          );
        }
      },
    );
  }
}

class MessageInputModel {
  final String chatNodeId;
  final String fcmToken;
  final String message;
  final int senderId;
  final int receiverId;
  final String senderName;
  final String senderProfile;
  final String receiverName;
  final String receiverProfile;
  final bool isReceiverInChat;
  final int unreadCount;
  final String status;

  MessageInputModel({
    required this.chatNodeId,
    required this.fcmToken,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.senderProfile,
    required this.senderName,
    required this.receiverProfile,
    required this.receiverName,
    required this.isReceiverInChat,
    required this.unreadCount,
    required this.status,
  });
}
