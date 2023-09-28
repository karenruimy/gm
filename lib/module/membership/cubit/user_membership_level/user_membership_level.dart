
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../models/user_membership_level.dart';

enum UserMembershipLevelStatus {
  none,
  loading,
  success,
  dataNotFound,
  failure,
}


class UserMembershipLevelState{
  final BaseFailure failure;
  final List<UserMembershipLevelModel> userMemberships;
  final UserMembershipLevelStatus userMembershipLevelStatus;

  UserMembershipLevelState({required this.failure, required this.userMemberships, required this.userMembershipLevelStatus});

  factory UserMembershipLevelState.initial() {
    return UserMembershipLevelState(
        userMembershipLevelStatus: UserMembershipLevelStatus.none,
        failure: const BaseFailure(),
        userMemberships: []);
  }

  UserMembershipLevelState copyWith({
    UserMembershipLevelStatus? userMembershipLevelStatus,
    BaseFailure? failure,
    List<UserMembershipLevelModel>? userMemberships,
  }) {
    return UserMembershipLevelState(
      userMembershipLevelStatus: userMembershipLevelStatus ?? this.userMembershipLevelStatus,
      failure: failure ?? this.failure,
      userMemberships: userMemberships ?? this.userMemberships,
    );
  }
}