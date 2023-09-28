import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';

class AccountTabTile extends StatefulWidget {
  final String accountTabTitle;

  const AccountTabTile({super.key, required this.accountTabTitle});

  @override
  State<AccountTabTile> createState() => _AccountTabTileState();
}

class _AccountTabTileState extends State<AccountTabTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.offWhiteColor,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Row(
            children: [
              Expanded(
                  child: TextView(
                widget.accountTabTitle,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              )),
              Image.asset(
                "assets/images/png/ic_forward_arrow.png",
                height: 20,
                width: 20,
              )
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColors.primaryLight1,
        ),
      ],
    );
  }
}
