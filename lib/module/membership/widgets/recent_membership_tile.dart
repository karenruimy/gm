import 'package:flutter/cupertino.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/membership/models/recent_membership_response.dart';

class RecentMembershipTile extends StatefulWidget {
  final RecentMembershipModel recentMembershipModel;

  const RecentMembershipTile({super.key, required this.recentMembershipModel});

  @override
  State<RecentMembershipTile> createState() => _RecentMembershipTileState();
}

class _RecentMembershipTileState extends State<RecentMembershipTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      'Name',
                      fontSize: 10,
                      color: AppColors.greyColor,
                    ),
                    TextView(
                      widget.recentMembershipModel.userNicename,
                      fontSize: 14,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      'Email',
                      fontSize: 10,
                      color: AppColors.greyColor,
                    ),
                    TextView(
                      widget.recentMembershipModel.userEmail,
                      fontSize: 14,
                      color: AppColors.blackColor,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                flex: 1,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      'Membership name',
                      fontSize: 10,
                      color: AppColors.greyColor,
                    ),
                    TextView(
                      widget.recentMembershipModel.membershipName,
                      fontSize: 14,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      'Status',
                      fontSize: 10,
                      color: AppColors.greyColor,
                    ),
                    TextView(
                      widget.recentMembershipModel.status,
                      fontSize: 14,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                flex: 1,
              )
            ],
          ),
          /*SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextView(
                    'Edit',
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextView(
                '|',
                color: AppColors.blue,
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextView(
                    'Delete',
                    color: AppColors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          )*/
        ],
      ),
    );
  }
}
