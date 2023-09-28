import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:goddessmembership/module/membership/cubit/membership_level_cubit/membership_level_cubit.dart';
import 'package:goddessmembership/module/membership/cubit/membership_level_cubit/membership_level_state.dart';
import 'package:goddessmembership/module/membership/cubit/user_membership_level/user_membership_cubit.dart';
import 'package:goddessmembership/module/membership/cubit/user_membership_level/user_membership_level.dart';

import '../../components/loading_indicator.dart';
import '../../components/text_view.dart';
import '../../config/routes/nav_router.dart';
import '../../core/di/service_locator.dart';
import '../../utils/display/display_utils.dart';
import '../dashboard/dashboard_screen.dart';

class StartupScreen extends StatefulWidget {
  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  AuthRepository _authRepository = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserMembershipLevelCubit(sl())
              ..fetchUserMemberships(_authRepository.user.id.toString())),
        BlocProvider(create: (context) => MembershipLevelCubit(sl())),
      ],
      child: BaseScaffold(
        body: BlocListener<MembershipLevelCubit, MembershipLevelState>(
          listener: (context, membershipLevelState) {
            if (membershipLevelState.membershipLevelStatus ==
                MembershipLevelStatus.loading) {}
            if (membershipLevelState.membershipLevelStatus ==
                MembershipLevelStatus.success) {
              DisplayUtils.removeLoader();
              NavRouter.pushAndRemoveUntil(context, DashboardScreen());
            }
            if (membershipLevelState.membershipLevelStatus ==
                MembershipLevelStatus.failure) {
              DisplayUtils.removeLoader();
              DisplayUtils.showSnackBar(
                  context, membershipLevelState.failure.message);
            }
          },
          child:
              BlocConsumer<UserMembershipLevelCubit, UserMembershipLevelState>(
            listener: (context, state) {
              if (state.userMembershipLevelStatus ==
                  UserMembershipLevelStatus.loading) {
                DisplayUtils.showLoader();
              } else if (state.userMembershipLevelStatus ==
                  UserMembershipLevelStatus.dataNotFound) {
                DisplayUtils.removeLoader();
                NavRouter.pushAndRemoveUntil(context, DashboardScreen());
              } else if (state.userMembershipLevelStatus ==
                  UserMembershipLevelStatus.success) {
                context
                    .read<MembershipLevelCubit>()
                    .fetchMembershipLevel(state.userMemberships.first.id);
              } else if (state.userMembershipLevelStatus ==
                  UserMembershipLevelStatus.failure) {
                DisplayUtils.removeLoader();
                DisplayUtils.showSnackBar(context, state.failure.message);
              }
            },
            builder: (context, state) {
              if (state.userMembershipLevelStatus ==
                  UserMembershipLevelStatus.loading) {
                return Center(
                  child: LoadingIndicator(),
                );
              }
              if (state.userMembershipLevelStatus ==
                  UserMembershipLevelStatus.failure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        state.failure.message,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.normal,
                      ),
                      /*SizedBox(
                        height: 8,
                      ),
                      IconButton(
                          onPressed: () {
                            UserMembershipLevelCubit(sl())
                              ..fetchUserMemberships(
                                  _authRepository.user.id.toString());
                          },
                          icon: Image.asset(
                            "assets/images/png/ic_sync.png",
                            color: AppColors.blue,
                          ))*/
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
