import 'package:flutter/material.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/config/config.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/chat/chat_screen.dart';

class ChatListTile extends StatefulWidget {
  final int senderId;
  final int receiverId;
  final String lastMessage;
  final String receiverName;
  final String receiverProfile;
  final String lastMessageTime;
  final String msgType;
  final int unreadCount;

  const ChatListTile({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.lastMessage,
    required this.receiverName,
    required this.receiverProfile,
    required this.lastMessageTime,
    required this.msgType,
    required this.unreadCount,
  });

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavRouter.push(
            context,
            ChatScreen(
              senderId: widget.senderId,
              receiverId: widget.receiverId,
              receiverName: widget.receiverName,
              receiverProfile: widget.receiverProfile,
            ));
      },
      child: Container(
        color: AppColors.offWhiteColor,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.receiverProfile),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      widget.receiverName,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.blackColor,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextView(
                      widget.msgType == 'text' ? widget.lastMessage : 'Image',
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.left,
                      fontSize: 13,
                      maxLines: 1,
                      color: AppColors.grey4,
                    )
                  ],
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      if (widget.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.all(4),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryDark,
                          ),
                          child: Center(
                            child: TextView(
                              widget.unreadCount > 9
                                  ? '9+'
                                  : widget.unreadCount.toString(),
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.left,
                              fontSize: 10,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 12,
                      ),
                      TextView(
                        widget.lastMessageTime,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.left,
                        fontSize: 13,
                        color: AppColors.grey4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: .5,
              color: AppColors.primaryLight,
            )
          ],
        ),
      ),
    );
  }
}
