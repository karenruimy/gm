import 'package:flutter/cupertino.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/notifications/widget/notification_tile.dart';

class NotificationsScreen extends StatelessWidget {
  List<NotificationModel> notificationsList = [
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),
    NotificationModel(
        imagePath: 'assets/images/jpg/dummy_image.jpg',
        title: 'Titles Of Post',
        description: 'Brief description of the post'),

  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        backgroundColor: AppColors.backgroundColor,
        hMargin: 0,
        appBar: const CustomAppbar(
          'Notifications',
          centerTitle: true,
          hasBackIcon: false,
        ),
        body: Column(
          children: [
            Container(
              height: 1,
              color: AppColors.primaryLight1,
            ),
            Expanded(child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: notificationsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    NotificationModel notificationModel = notificationsList[index];
                    return GestureDetector(
                      child: NotificationTile(notificationModel: notificationModel,),
                      onTap: () {

                      },
                    );
                  }),
            ),),
          ],
        ));
  }
}

class NotificationModel {
  final String imagePath;
  final String title;
  final String description;

  NotificationModel(
      {required this.imagePath,
      required this.title,
      required this.description});
}
