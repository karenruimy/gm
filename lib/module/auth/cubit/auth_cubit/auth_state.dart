part of 'auth_cubit.dart';

enum AuthStatus {
  none,
  authenticated,
  unauthenticated,
  userLoading,
  userSuccess,
  loading,
  loggingOut,

}

class AuthState {
  final AuthStatus authStatus;
  final BaseFailure failure;
  final bool isPasswordHidden;
  final bool isAutoValidate;

  AuthState({
    required this.authStatus,
    required this.isPasswordHidden,
    required this.isAutoValidate,
    required this.failure,
  });

  factory AuthState.unknown() {
    return AuthState(
      authStatus: AuthStatus.none,
      isPasswordHidden: true,
      isAutoValidate: false,
      failure: const BaseFailure(),);
  }

  @override
  String toString() => 'AuthState(authStatus: $authStatus)';

  AuthState copyWith({
    AuthStatus? authStatus,
    bool? isPasswordVisible,
    bool? isAutoValidate,
    BaseFailure? failure,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      isPasswordHidden: isPasswordVisible ?? isPasswordHidden,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
      failure: failure ?? this.failure,
    );
  }
}
