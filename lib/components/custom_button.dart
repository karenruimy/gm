import 'package:flutter/material.dart';
import 'package:goddessmembership/components/text_view.dart';

import '../../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.textColor = AppColors.whiteColor,
      this.backgroundColor = AppColors.primaryDark,
      this.isOutlinedButton = false,
      this.horizontalPadding = 0,
      this.isRounded = true,
      this.isEnabled = true,
      this.height = 44,
      this.disabledColor,
      this.upperCase = false,
      this.isLogoutButton = false,
      this.hasIcon = false,
      this.icon,
      this.borderRadius = 10,this.fontSize = 14})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final double? fontSize;
  final Color textColor;
  final Color backgroundColor;
  final bool isOutlinedButton;
  final double horizontalPadding;
  final double height;
  final bool isRounded;
  final bool isEnabled;
  final Color? disabledColor;
  final bool isLogoutButton;
  final bool hasIcon;
  final IconData? icon;
  final bool upperCase;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      width: double.infinity,
      child: TextButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          // splashFactory:
          //     isEnabled ? InkRipple.splashFactory : NoSplash.splashFactory,
          backgroundColor:
              isOutlinedButton ? Colors.transparent : backgroundColor,
          disabledForegroundColor: AppColors.primaryDark.withOpacity(0.38),
          disabledBackgroundColor: AppColors.primaryDark.withOpacity(0.12),
          side: BorderSide(
            color: isEnabled
                ? isLogoutButton
                    ? Colors.transparent
                    : backgroundColor
                : Colors.transparent,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasIcon)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  icon!,
                  color: AppColors.whiteColor,
                  size: 20,
                ),
              ),
            TextView(
              upperCase ? title.toUpperCase() : title.toString(),
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}
