part of 'users_list_cubit.dart';

enum UsersListStatus {
  none,
  loading,
  success,
  failure,
}

class UsersListState {
  final BaseFailure failure;
  final List<User> users;
  final UsersListStatus usersListStatus;

  UsersListState({
    required this.failure,
    required this.users,
    required this.usersListStatus,
  });

  factory UsersListState.initial() {
    return UsersListState(
      usersListStatus: UsersListStatus.none,
      failure: const BaseFailure(),
      users: [],
    );
  }

  UsersListState copyWith({
    UsersListStatus? usersListStatus,
    BaseFailure? failure,
    List<User>? users,
  }) {
    return UsersListState(
      usersListStatus: usersListStatus ?? this.usersListStatus,
      failure: failure ?? this.failure,
      users: users ?? this.users,
    );
  }
}
