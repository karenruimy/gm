import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    required this.body,
    this.safeAreaTop = false,
    this.safeAreaBottom = true,
    this.hMargin = 18,
    this.appBar,
    this.backgroundColor = AppColors.whiteColor,
    this.bottomNavigationBar,
    this.drawer,
  }) : super(key: key);
  final Widget body;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final double hMargin;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      key: key,
      appBar: appBar,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: hMargin),
          child: body,
        ),
      ),
    );
  }
}
