



import 'package:goddessmembership/module/membership/models/levels_response.dart';

import '../../../../core/failures/base_failures/base_failure.dart';

enum MembershipLevelStatus {
  none,
  loading,
  success,
  failure,
}


class MembershipLevelState{
  final BaseFailure failure;
  final MembershipLevelModel? membershipLevelModel;
  final MembershipLevelStatus membershipLevelStatus;

  MembershipLevelState({required this.failure, required this.membershipLevelModel, required this.membershipLevelStatus});

  factory MembershipLevelState.initial() {
    return MembershipLevelState(
        membershipLevelStatus: MembershipLevelStatus.none,
        failure: const BaseFailure(),
        membershipLevelModel: null);
  }

  MembershipLevelState copyWith({
    MembershipLevelStatus? membershipLevelStatus,
    BaseFailure? failure,
    MembershipLevelModel? membershipLevelModel,
  }) {
    return MembershipLevelState(
      membershipLevelStatus: membershipLevelStatus ?? this.membershipLevelStatus,
      failure: failure ?? this.failure,
      membershipLevelModel: membershipLevelModel ?? this.membershipLevelModel,
    );
  }
}