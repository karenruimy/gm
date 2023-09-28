import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'bottom_nav_icon.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.selectedIndex, required this.onTap}) : super(key: key);

  final int selectedIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isIOS ? 90 : 76,
      padding: Platform.isIOS ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: BottomNavIcon(
              callback: () => onTap(0),
              outlinedPath: 'assets/images/png/goodess.png',
              filledPath: 'assets/images/png/goodess.png',
              isSelected: selectedIndex == 0,
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () => onTap(1),
              outlinedPath: 'assets/images/png/explore.png',
              filledPath: 'assets/images/png/explore.png',
              isSelected: selectedIndex == 1,
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () => onTap(2),
              outlinedPath: 'assets/images/png/chats.png',
              filledPath: 'assets/images/png/chats.png',
              isSelected: selectedIndex == 2,
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () => onTap(3),
              outlinedPath: 'assets/images/png/acc.png',
              filledPath: 'assets/images/png/acc.png',
              isSelected: selectedIndex == 3,
            ),
          ),
        ],
      ),
    );
  }
}
