import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/components/loading_indicator.dart';
import 'package:goddessmembership/config/config.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:goddessmembership/module/chat/widgets/chat_list_tile.dart';
import 'package:goddessmembership/module/users_list/pages/users_list_page.dart';
import 'package:intl/intl.dart';

import '../../core/di/service_locator.dart';

class ChatListScreen extends StatefulWidget {
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  AuthRepository _repository = sl<AuthRepository>();

  late int senderId;

  @override
  void initState() {
    senderId = _repository.user.id;
    print("sender Id : ${senderId}");
    super.initState();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Filter senderFilter = Filter('senderId', isEqualTo: senderId);
    Filter receiverFilter = Filter('receiverId', isEqualTo: senderId);
    return BaseScaffold(
      backgroundColor: AppColors.backgroundColor,
      hMargin: 0,
      appBar: CustomAppbar(
        'Chats',
        centerTitle: true,
        hasBackIcon: false,
        actions: [
          IconButton(
            onPressed: () {
              NavRouter.push(context, UsersListPage());
            },
            icon: Icon(
              Icons.add,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 1,
            color: AppColors.primaryLight1,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chats')
                    .where(Filter.or(senderFilter, receiverFilter))
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return Center(
                        child: Text(
                          'No Chat Found',
                        ),
                      );
                    }
                    return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data.docs[index]['msgType']);
                          DateTime dateTime = snapshot.data.docs[index]['time'].toDate();
                          String formattedTime = DateFormat('h:mm a').format(dateTime);
                          return ChatListTile(
                            senderId: senderId,
                            receiverId: senderId != snapshot.data.docs[index]['receiverId']
                                ? snapshot.data.docs[index]['receiverId']
                                : snapshot.data.docs[index]['senderId'],
                            receiverName: senderId != snapshot.data.docs[index]['receiverId']
                                ? snapshot.data.docs[index]['receiverName']
                                : snapshot.data.docs[index]['senderName'],
                            receiverProfile: 'assets/images/jpg/ic_profile_placeholder.jpg',
                            lastMessage: snapshot.data.docs[index]['last_msg'],
                            msgType: snapshot.data.docs[index]['msgType'],
                            lastMessageTime: formattedTime,
                            unreadCount: senderId == snapshot.data.docs[index]['receiverId']
                                ? snapshot.data.docs[index]['unreadCount']
                                : 0,
                          );
                        });
                  }
                  return Center(
                    child: LoadingIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
