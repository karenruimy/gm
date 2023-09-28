import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/users_list/repo/users_list_repo.dart';

import '../../../core/failures/base_failures/base_failure.dart';
import '../../../core/failures/high_priority_failure.dart';
import '../../auth/models/user.dart';

part 'users_list_state.dart';

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit(this._repository) : super(UsersListState.initial());

  UsersListRepository _repository;

  Future fetchAllUsers() async {
    emit(state.copyWith(usersListStatus: UsersListStatus.loading));

    try {
      List<User> response = await _repository.getUsersList();
      if (response.isNotEmpty) {
        emit(state.copyWith(
          usersListStatus: UsersListStatus.success,
          users: response
        ));
      } else {
        emit(state.copyWith(
            usersListStatus: UsersListStatus.failure,
            failure: HighPriorityException("Data not found...")));
      }
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          usersListStatus: UsersListStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }
}
