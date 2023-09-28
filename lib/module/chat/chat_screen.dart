import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/components/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:goddessmembership/module/chat/widgets/receiver_tile.dart';
import 'package:goddessmembership/module/chat/widgets/sender_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goddessmembership/utils/display/dialogs/dialog_utils.dart';
import 'package:goddessmembership/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/di/service_locator.dart';
import '../../core/notifications/cloud_messaging_service.dart';
import 'cubit/chat_cubit.dart';
import 'cubit/image_picker_cubit/image_picker_cubit.dart';
import 'repo/chat_repo.dart';
import 'repo/image_picker_repo.dart';

class ChatScreen extends StatefulWidget {
  final int senderId;
  final int receiverId;
  final String receiverName;
  final String receiverProfile;

  ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverProfile,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference tokens = FirebaseFirestore.instance.collection('tokens');

  AuthRepository authRepository = sl<AuthRepository>();

  final TextEditingController messageController = TextEditingController();

  String chatNodeId = '';
  String receiverToken = '';
  bool isUserOnline = false;

  @override
  void initState() {
    if (widget.senderId > widget.receiverId) {
      chatNodeId = widget.receiverId.toString() + widget.senderId.toString();
    } else if (widget.senderId < widget.receiverId) {
      chatNodeId = widget.senderId.toString() + widget.receiverId.toString();
    }
    print(chatNodeId);
    WidgetsBinding.instance.addObserver(this);
    resetUnreadCount();
    markMessagesAsRead();

    updateUserStatus(true, widget.senderId.toString());

    getFcmToken(widget.receiverId.toString());
    super.initState();
  }

  File? imageFile;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await updateUserStatus(true, widget.senderId.toString());
      resetUnreadCount();
    } else {
      await updateUserStatus(false, widget.senderId.toString());
    }
  }

  void markMessagesAsRead() async {
    // Get a reference to your Firestore collection containing messages
    CollectionReference messagesCollection =
        firestore.collection('chats').doc(chatNodeId).collection('messages');

// Query for unread messages
    QuerySnapshot unreadMessagesQuery = await messagesCollection
        .where('receiverId', isEqualTo: widget.senderId)
        .where('status', isEqualTo: 'unread')
        .get();

    // Loop through the unread messages and update their status to 'read'
    for (QueryDocumentSnapshot messageDoc in unreadMessagesQuery.docs) {
      // Update the status field to 'read'
      await messageDoc.reference.update({'status': 'read'});
    }

    print('All unread messages marked as read.');
  }

// Call this function when you open the screen

  Future<int> getUnreadCount(String chatNodeId) async {
    final chatDocRef =
        FirebaseFirestore.instance.collection('chats').doc(chatNodeId);

    final chatDocSnapshot = await chatDocRef.get();
    if (chatDocSnapshot.exists) {
      final data = chatDocSnapshot.data() as Map<String, dynamic>;
      final unreadCount = data['unreadCount'] ?? 0;
      return unreadCount;
    } else {
      return 0;
    }
  }

  Future getImage(ImageSource source) async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: source).then((xFile) {
      if (xFile != null) {
        setState(() {
          imageFile = File(xFile.path);
        });
        print('File Picked');
        uploadImage();
      } else {
        print('Image not selected');
      }
    });
  }

  Future uploadImage() async {
    // it will generate random file name
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    int status = 1;

    print('UserOnlineStatus ::: $isUserOnline');
    // It will create instance of msg into firebase Like, reserve memory
    await await checkUserStatus(widget.receiverId.toString()).then((value) {
      firestore
          .collection('chats')
          .doc(chatNodeId)
          .collection('messages')
          .doc(fileName)
          .set({
        'senderId': widget.senderId,
        'receiverId': widget.receiverId,
        'message': '',
        'type': 'img',
        'time': DateTime.now(),
        'status': value ? 'read' : 'unread',
      });
    });

    var ref =
        FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');

    print("Image Upload Ref. $ref");

    // if there is any error while uploading image we will delete the above created instance
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      print("Upload Error ::: ${error}");
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatNodeId)
          .collection('messages')
          .doc(fileName)
          .delete();

      status = 0;

      return;
    });

    // status 1 = upload successfully, then we update the empty msg '' with image url
    if (status == 1) {
      print('Status is 1');
      // return the url after uploading image to firebase storage
      String imageUrl = await uploadTask.ref.getDownloadURL();
      int unreadCount = await getUnreadCount(chatNodeId);

      await checkUserStatus(widget.receiverId.toString()).then((userStatus) {
        firestore
            .collection('chats')
            .doc(chatNodeId)
            .collection('messages')
            .doc(fileName)
            .update({"message": imageUrl})
            .then((value) => FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatNodeId)
                    .set({
                  'senderId': widget.senderId,
                  'receiverId': widget.receiverId,
                  'senderName': authRepository.user.name,
                  'receiverName': widget.receiverName,
                  'senderProfile': '',
                  'receiverProfile': widget.receiverProfile,
                  'last_msg': imageUrl,
                  'msgType': 'img',
                  'unreadCount': !userStatus ? unreadCount + 1 : 0,
                  'time': DateTime.now(),
                }))
            .then((value) {
              if (!userStatus) {
                CloudMessagingService.sendNotification(
                  receiverToken,
                  authRepository.user.name,
                  'image',
                );
              }
            });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void getFcmToken(String receiverId) {
    final docRef = firestore.collection("users").doc(receiverId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          // ...
          receiverToken = data['FcmToken'];
          print("----- ${data['FcmToken']}");
        } else {
          print("No document found for senderId: ${receiverId}");
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<bool> checkUserStatus(String receiverId) async {
    final docRef = firestore.collection("users").doc(receiverId);
    bool userStatus = false;
    await docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          userStatus = data['isOnline'];
          print("----- $userStatus");
        } else {
          print("No document found for receiverId: ${receiverId}");
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return userStatus;
  }

  void resetUnreadCount() async {
    CollectionReference chatsCollection = firestore.collection('chats');

    QuerySnapshot<Map<String, dynamic>> chatQuerySnapshot =
        await chatsCollection
            .where('receiverId', isEqualTo: widget.senderId)
            .limit(1)
            .get() as QuerySnapshot<Map<String, dynamic>>;

    try {
      if (chatQuerySnapshot.docs.isNotEmpty) {
        DocumentReference chatDocRef =
            firestore.collection('chats').doc(chatNodeId);

        print(' Chat ref ${chatDocRef}');

        await chatDocRef.update({'unreadCount': 0});
      } else {
        print('Error updating unread count');
      }
      print('Unread count updated successfully.');
    } catch (e) {
      print('Error updating unread count: $e');
    }
  }

  Future<void> updateUserStatus(bool isOnline, String receiverId) async {
    isUserOnline = isOnline;
    try {
      await firestore.collection('users').doc(receiverId).update({
        'isOnline': isOnline,
      });
    } catch (error) {
      print('Error updating user status: $error');
    }
  }

  bool chatInitiated = true;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    );
    return BlocProvider(
      create: (context) =>
          ChatCubit(ImagePickerCubit(ImagePickerRepo()), ChatRepository()),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              updateUserStatus(false, widget.senderId.toString());
              print("Change status");
              return true;
            },
            child: BaseScaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: CustomAppbar(
                widget.receiverName,
                leadingWidth: 85,
                leading: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        updateUserStatus(false, widget.senderId.toString());
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        "assets/images/png/ic_back_arrow.png",
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 35,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/jpg/ic_profile_placeholder.jpg',
                            ),
                          )),
                    )
                  ],
                ),
                hasBackIcon: false,
              ),
              body: Column(
                children: [
                  Container(
                    height: 1,
                    color: AppColors.primaryLight1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: StreamBuilder(
                        stream: firestore
                            .collection('chats')
                            .doc(chatNodeId)
                            .collection('messages')
                            .orderBy('time', descending: true)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length < 1) {
                              chatInitiated = false;
                              return Center(
                                child: Text(
                                  'Start Conversation',
                                  style: context.textTheme.bodyMedium,
                                ),
                              );
                            }
                            return ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: snapshot.data.docs.length,
                              reverse: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                bool isMe = snapshot.data.docs[index]
                                        ['senderId'] ==
                                    widget.senderId;
                                return isMe
                                    ? SenderTile(
                                        message: snapshot.data.docs[index]
                                            ['message'],
                                        msgType: snapshot.data.docs[index]
                                            ['type'],
                                        time: DateFormat.jm().format(
                                            (snapshot.data.docs[index]['time'])
                                                .toDate()),
                                        status: snapshot.data.docs[index]
                                                    ['status'] ==
                                                'read'
                                            ? true
                                            : false,
                                      )
                                    : ReceiverTile(
                                        isOnline: isUserOnline,
                                        message: snapshot.data.docs[index]
                                            ['message'],
                                        msgType: snapshot.data.docs[index]
                                            ['type'],
                                        time: DateFormat.jm().format(
                                            (snapshot.data.docs[index]['time'])
                                                .toDate()),
                                      );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.primaryDark,
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.only(right: 18),
                          icon: Image.asset(
                            "assets/images/png/ic_plus.png",
                            color: AppColors.whiteColor,
                            height: 20,
                            width: 20,
                          ),
                          onPressed: () async {
                            String res =
                                await DialogUtils.uploadPictureDialog(context);
                            if (res == 'gallery') {
                              getImage(ImageSource.gallery);
                            } else if (res == 'camera') {
                              getImage(ImageSource.camera);
                            }
                          },
                        ),
                        Expanded(
                            child: CustomTextField(
                          height: 38,
                          fontSize: 14,
                          verticalPadding: 10,
                          controller: messageController,
                          fillColor: AppColors.whiteColor,
                          hintText: 'Type message...',
                          bottomMargin: 0,
                        )),
                        GestureDetector(
                          onTap: () async {
                            print(messageController.text);
                            if (messageController.text.trim() != '') {
                              var msg = messageController.text;
                              messageController.clear();
                              int unreadCount =
                                  await getUnreadCount(chatNodeId);
                              await checkUserStatus(
                                      widget.receiverId.toString())
                                  .then((value) {
                                var messageInput = MessageInputModel(
                                  chatNodeId: chatNodeId,
                                  message: msg,
                                  senderId: widget.senderId,
                                  receiverId: widget.receiverId,
                                  senderName: authRepository.user.name,
                                  senderProfile: '',
                                  receiverName: widget.receiverName,
                                  receiverProfile: widget.receiverProfile,
                                  fcmToken: receiverToken,
                                  isReceiverInChat: value,
                                  unreadCount: !value ? unreadCount + 1 : 0,
                                  status: value ? 'read' : 'unread',
                                );

                                context
                                    .read<ChatCubit>()
                                    .sendTextMessage(messageInput);
                              });
                              getUnreadCount(chatNodeId);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 18),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Image.asset(
                              "assets/images/png/ic_send_message.png",
                              color: AppColors.primaryDark,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              hMargin: 0,
            ),
          );
        },
      ),
    );
  }
}
