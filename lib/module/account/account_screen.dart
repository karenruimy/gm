import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/components/custom_button.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/account/widget/account_tab_tile.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:goddessmembership/module/membership/pages/recent_memberships_screen.dart';
import 'package:goddessmembership/module/profile/pages/profile_screen.dart';

import '../../config/routes/nav_router.dart';
import '../../core/di/service_locator.dart';
import '../../utils/display/dialogs/dialog_utils.dart';
import '../auth/cubit/auth_cubit/auth_cubit.dart';
import '../auth/pages/login_page.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<String> accountTabList = [
    'Account & Subscription',
    'My Profile',
    'Notifications',
    'Support',
    'Terms & Conditions',
    'Privacy Policy',
  ];

  AuthRepository _authRepository = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        backgroundColor: AppColors.backgroundColor,
        hMargin: 0,
        appBar: CustomAppbar(
          'Account',
          hasBackIcon: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 1,
                color: AppColors.primaryLight1,
              ),
              Column(
                children: List.generate(accountTabList.length, (index) {
                  return GestureDetector(
                    child:
                        AccountTabTile(accountTabTitle: accountTabList[index]),
                    onTap: () {
                      if (index == 0) {
                        NavRouter.push(context, RecentMemberships());
                      } else if (index == 1) {
                        NavRouter.push(context, ProfileScreen());
                      }
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextView(
                    "Logged in as",
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextView(
                    _authRepository.user.name,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    child: CustomButton(
                      onPressed: () {
                        DialogUtils.confirmationDialog(
                            context: context,
                            title: 'Confirmation!',
                            content:
                                'Are you sure you want to logout from the app?',
                            onPressYes: () {
                              context.read<AuthCubit>()..logout();
                              NavRouter.pushAndRemoveUntil(
                                  context, LoginScreen());
                            });
                      },
                      height: 36,
                      title: 'Log out',
                      borderRadius: 8,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
