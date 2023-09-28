import 'package:flutter/material.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/account/account_screen.dart';
import 'package:goddessmembership/module/chat/chat_list_screen.dart';
import 'package:goddessmembership/module/dashboard/navbar.dart';
import 'package:goddessmembership/module/post/pages/post_screen.dart';

import '../categories/pages/categories_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        hMargin: 0,
        safeAreaBottom: false,
        safeAreaTop: false,
        backgroundColor: AppColors.whiteColor,
        // bottomNavigationBar: Container(
        //   color: AppColors.primaryDark,
        //   padding: const EdgeInsets.only(bottom: 25, top: 10),
        //   child: BottomNavigationBar(
        //     unselectedItemColor: AppColors.primaryLight,
        //     backgroundColor: AppColors.primaryDark,
        //     selectedItemColor: AppColors.whiteColor,
        //     type: BottomNavigationBarType.fixed,
        //     selectedLabelStyle: const TextStyle(
        //         height: 1.5, fontSize: 12, color: AppColors.whiteColor),
        //     unselectedLabelStyle: const TextStyle(
        //         fontSize: 12, height: 1.5, color: AppColors.primaryLight),
        //     elevation: 0,
        //     items: <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: Padding(
        //           padding: const EdgeInsets.only(bottom: 6),
        //           child: Image.asset(
        //             "assets/images/png/ic_goddess.png",
        //             color: _selectedIndex == 0
        //                 ? AppColors.whiteColor
        //                 : AppColors.primaryLight,
        //             height: 24,
        //             width: 24,
        //           ),
        //         ),
        //         label: 'Goddess',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Padding(
        //           padding: const EdgeInsets.only(bottom: 6),
        //           child: Image.asset(
        //             "assets/images/png/ic_notification.png",
        //             color: _selectedIndex == 1
        //                 ? AppColors.whiteColor
        //                 : AppColors.primaryLight,
        //           ),
        //         ),
        //         label: 'Notifications',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Padding(
        //           padding: const EdgeInsets.only(bottom: 6),
        //           child: Image.asset(
        //             "assets/images/png/ic_chat.png",
        //             color: _selectedIndex == 2
        //                 ? AppColors.whiteColor
        //                 : AppColors.primaryLight,
        //           ),
        //         ),
        //         label: 'Chat',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Padding(
        //           padding: const EdgeInsets.only(bottom: 6),
        //           child: Image.asset(
        //             "assets/images/png/ic_account.png",
        //             color: _selectedIndex == 4
        //                 ? AppColors.whiteColor
        //                 : AppColors.primaryLight,
        //           ),
        //         ),
        //         label: 'Account',
        //       ),
        //     ],
        //     currentIndex: _selectedIndex,
        //     onTap: _onItemTapped,
        //   ),
        // ),
        bottomNavigationBar:
            NavBar(selectedIndex: _selectedIndex, onTap: _onItemTapped),
        body: <Widget>[
          PostsScreen(
            pageTitle: "Goddess Membership",
            categoryId: 1,
            hasBackIcon: false,
          ),
          CategoriesScreen(),
          ChatListScreen(),
          AccountScreen(),
        ][_selectedIndex]);
  }
}
