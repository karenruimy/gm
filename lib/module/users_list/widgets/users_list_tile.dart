import 'package:flutter/material.dart';
import 'package:goddessmembership/config/config.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:goddessmembership/module/chat/chat_screen.dart';

import '../../../components/text_view.dart';
import '../../../constants/app_colors.dart';
import '../../../core/di/service_locator.dart';
import '../../auth/models/user.dart';

class UsersListTile extends StatefulWidget {
  final User user;

  const UsersListTile({super.key, required this.user});

  @override
  State<UsersListTile> createState() => _UsersListTileState();
}

class _UsersListTileState extends State<UsersListTile> {
  AuthRepository _repository = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        color: AppColors.offWhiteColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/images/jpg/ic_profile_placeholder.jpg"),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextView(
                          widget.user.name,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: AppColors.blackColor,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            NavRouter.push(
                              context,
                              ChatScreen(
                                senderId: _repository.user.id,
                                receiverId: widget.user.id,
                                receiverName: widget.user.name,
                                receiverProfile: '',
                              ),
                            );
                          },
                          icon: Image.asset(
                            "assets/images/png/ic_message.png",
                          ))
                    ],
                  ),
                )),
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
