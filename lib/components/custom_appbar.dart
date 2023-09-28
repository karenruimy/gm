import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goddessmembership/components/text_view.dart';

import '../constants/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
    this.title, {
    this.centerTitle = false,
    this.actions,
    this.onBackIconClicked,
    this.elevation = 0,
    this.hasBackIcon = true,
    this.leadingWidth = 56.0,
    this.leading,
    Key? key,
  }) : super(key: key);
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final VoidCallback? onBackIconClicked;
  final double elevation;
  final bool hasBackIcon;
  final Widget? leading;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: AppColors.whiteColor,
      elevation: elevation,
      centerTitle: centerTitle,
      actions: actions,
      leadingWidth: leadingWidth,
      leading: hasBackIcon == true
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/images/png/ic_back_arrow.png",
                height: 20,
              ),
            )
          : leading,
      title: TextView(
        title,
        fontSize: 16,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w800,
        color: AppColors.blackColor,
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
