import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/membership/cubit/recent_membership_cubit/recent_membership_cubit.dart';
import 'package:goddessmembership/module/membership/widgets/recent_membership_tile.dart';

import '../../../components/loading_indicator.dart';
import '../../../core/di/service_locator.dart';
import '../cubit/recent_membership_cubit/recent_membership_state.dart';

class RecentMemberships extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RecentMembershipCubit(sl())..fetchRecentMemberships(),
      child: BaseScaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppbar(
          'Recent Memberships',
        ),
        hMargin: 0,
        body: BlocBuilder<RecentMembershipCubit, RecentMembershipState>(
          builder: (context, state) {
            if (state.recentMembershipStatus ==
                RecentMembershipStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }
            if (state.recentMembershipStatus ==
                RecentMembershipStatus.success) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: state.recentMemberships.length,
                  itemBuilder: (context, index) {
                    return RecentMembershipTile(recentMembershipModel: state.recentMemberships[index],);
                  });
            }

            if (state.recentMembershipStatus ==
                RecentMembershipStatus.failure) {
              return Center(
                child: Text(state.failure.message),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
