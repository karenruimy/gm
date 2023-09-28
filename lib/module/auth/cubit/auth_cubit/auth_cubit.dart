import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:goddessmembership/module/auth/models/auth_response.dart';

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../repo/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthState.unknown());
  final AuthRepository _authRepository;

  void toggleShowPassword() => emit(
        state.copyWith(
          isPasswordVisible: !state.isPasswordHidden,
          authStatus: AuthStatus.none,
        ),
      );

  void enableAutoValidateMode() => emit(
        state.copyWith(
          isAutoValidate: true,
          authStatus: AuthStatus.none,
        ),
      );

  void login(LoginInput input) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      TokenResponse login = await _authRepository.getAuthToken(input);
      print("Token is --- ${login.jwtToken}");
      if (login.jwtToken.isNotEmpty) {
        emit(state.copyWith(authStatus: AuthStatus.authenticated));
      } else {
        print("else");
        emit(state.copyWith(
            authStatus: AuthStatus.unauthenticated,
            failure: HighPriorityException("Authentication failed...")));
      }
    } on BaseFailure catch (e) {
      print("Base Failure --- $e");
      emit(state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      print("Catch --- $_");
      emit(state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          failure: HighPriorityException(_.toString())));
    }
  }


  void logout() async {
    emit(state.copyWith(authStatus: AuthStatus.loggingOut));
    await Future.delayed(const Duration(seconds: 2));
    await _authRepository.logout();
    emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
  }
}

class LoginInput {
  final String username;
  final String password;

  LoginInput({
    required this.username,
    required this.password,
  });

  FormData toFormData() => FormData.fromMap({
    'email': username,
    'password': password,
  });
}


class SignupInput {
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  SignupInput({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  FormData toFormData() => FormData.fromMap({
    'username': username,
    'first_name': firstname,
    'last_name': lastname,
    'email': email,
    'password': password,
  });
}