
import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/membership/cubit/user_membership_level/user_membership_level.dart';
import 'package:goddessmembership/module/membership/models/user_membership_level.dart';

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../repo/membership_repo.dart';

class UserMembershipLevelCubit extends Cubit<UserMembershipLevelState> {
  UserMembershipLevelCubit(this._repository)
      : super(UserMembershipLevelState.initial());
  MembershipRepository _repository;

  Future fetchUserMemberships(String userId) async {
    emit(state.copyWith(userMembershipLevelStatus: UserMembershipLevelStatus.loading));

    try {
      List<UserMembershipLevelModel> response = await _repository.getMembershipLevelForUser(userId);
      if(response.isEmpty){
        emit(state.copyWith(
          userMembershipLevelStatus: UserMembershipLevelStatus.dataNotFound,
        ));
      }else{
        emit(state.copyWith(
          userMembershipLevelStatus: UserMembershipLevelStatus.success,
          userMemberships: response,
        ));
      }
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          userMembershipLevelStatus: UserMembershipLevelStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }
}