import 'package:flutter/cupertino.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/notifications/notifications_screen.dart';

class NotificationTile extends StatefulWidget {
  final NotificationModel notificationModel;

  const NotificationTile({super.key, required this.notificationModel});

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        fit: BoxFit.fill,
                        image: AssetImage(widget.notificationModel.imagePath))),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    widget.notificationModel.title,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppColors.blackColor,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 4,),
                  TextView(
                    widget.notificationModel.description,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    fontSize: 13,
                    color: AppColors.blackColor,
                  )
                ],
              )),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 14),child: TextView(
                "1hr",
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
                fontSize: 14,
                color: AppColors.blackColor,
              ),),
            ],
          ),
          Container(
            height: .5,
            color: AppColors.primaryLight,
          )
        ],
      ),
    );
  }
}