import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:goddessmembership/module/auth/cubit/signup_cubit/signup_state.dart';

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../models/user.dart';
import '../../repo/auth_repository.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authRepository) : super(SignupState.initial());
  final AuthRepository _authRepository;
  void toggleShowPassword() => emit(
    state.copyWith(
      isPasswordVisible: !state.isPasswordHidden,
      signupStatus: SignupStatus.none,
    ),
  );

  void enableAutoValidateMode() => emit(
    state.copyWith(
      isAutoValidate: true,
      signupStatus: SignupStatus.none,
    ),
  );

  void signup(SignupInput input) async {
    emit(state.copyWith(signupStatus: SignupStatus.loading));

    try {
      User user = await _authRepository.signup(input);
      if (user.id != -1) {
        emit(state.copyWith(signupStatus: SignupStatus.userSuccess));
      } else {
        emit(state.copyWith(
            signupStatus: SignupStatus.failure,
            failure: HighPriorityException("Authentication failed...")));
      }
    } on BaseFailure catch (e) {
      print("Base Failure --- $e");
      emit(state.copyWith(
          signupStatus: SignupStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      print("Catch --- $_");
      emit(state.copyWith(
          signupStatus: SignupStatus.failure,
          failure: HighPriorityException("Something went wrong...")));
    }
  }
}
