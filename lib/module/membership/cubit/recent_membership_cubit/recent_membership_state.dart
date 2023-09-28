

import 'package:goddessmembership/module/membership/models/recent_membership_response.dart';

import '../../../../core/failures/base_failures/base_failure.dart';


enum RecentMembershipStatus {
  none,
  loading,
  success,
  failure,
}

class RecentMembershipState {
  final BaseFailure failure;
  final List<RecentMembershipModel> recentMemberships;
  final RecentMembershipStatus recentMembershipStatus;

  RecentMembershipState(
      {required this.failure, required this.recentMemberships,  required this.recentMembershipStatus});

  factory RecentMembershipState.initial() {
    return RecentMembershipState(
        recentMembershipStatus: RecentMembershipStatus.none,
        failure: const BaseFailure(),
        recentMemberships: []
    );
  }

  RecentMembershipState copyWith({
    RecentMembershipStatus? recentMembershipStatus,
    BaseFailure? failure,
    List<RecentMembershipModel>? recentMemberships,
  }) {
    return RecentMembershipState(
      recentMembershipStatus: recentMembershipStatus ?? this.recentMembershipStatus,
      failure: failure ?? this.failure,
      recentMemberships: recentMemberships ?? this.recentMemberships,
    );
  }
}