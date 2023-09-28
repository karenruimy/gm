part of 'user_cubit.dart';

enum UserStatus {
  none,
  userSuccess,
  loading,
  failure
}

class UserState {
  final UserStatus userStatus;
  final BaseFailure failure;

  UserState({
    required this.userStatus,
    required this.failure,
  });

  factory UserState.initial() {
    return UserState(userStatus: UserStatus.none,failure: const BaseFailure(),);
  }

  @override
  String toString() => 'UserState(userStatus: $userStatus)';

  UserState copyWith({
    UserStatus? userStatus,
    BaseFailure? failure,
  }) {
    return UserState(
      userStatus: userStatus ?? this.userStatus,
      failure: failure ?? this.failure,
    );
  }
}

