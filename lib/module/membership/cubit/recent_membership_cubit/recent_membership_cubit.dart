import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/membership/cubit/recent_membership_cubit/recent_membership_state.dart';
import 'package:goddessmembership/module/membership/models/recent_membership_response.dart';
import 'package:goddessmembership/module/membership/repo/membership_repo.dart';

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';

class RecentMembershipCubit extends Cubit<RecentMembershipState> {
  RecentMembershipCubit(this._repository)
      : super(RecentMembershipState.initial());
  MembershipRepository _repository;

  Future fetchRecentMemberships() async {
    emit(
        state.copyWith(recentMembershipStatus: RecentMembershipStatus.loading));

    try {
      List<RecentMembershipModel> response =
          await _repository.getRecentMemberships();
      emit(state.copyWith(
        recentMembershipStatus: RecentMembershipStatus.success,
        recentMemberships: response,
      ));
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          recentMembershipStatus: RecentMembershipStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }
}
