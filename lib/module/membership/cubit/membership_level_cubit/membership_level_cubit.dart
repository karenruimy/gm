import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/membership/cubit/membership_level_cubit/membership_level_state.dart';
import 'package:goddessmembership/module/membership/models/levels_response.dart';

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../repo/membership_repo.dart';

class MembershipLevelCubit extends Cubit<MembershipLevelState> {
  MembershipLevelCubit(this._repository)
      : super(MembershipLevelState.initial());
  MembershipRepository _repository;

  Future fetchMembershipLevel(String levelId) async {
    emit(state.copyWith(membershipLevelStatus: MembershipLevelStatus.loading));

    try {
      MembershipLevelModel response = await _repository.getMembershipLevel(levelId);
      emit(state.copyWith(
        membershipLevelStatus: MembershipLevelStatus.success,
        membershipLevelModel: response,
      ));
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          membershipLevelStatus: MembershipLevelStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }
}
