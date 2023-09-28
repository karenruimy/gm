

import '../../../../core/failures/base_failures/base_failure.dart';

enum SignupStatus {
  none,
  userSuccess,
  loading,
  failure
}

class SignupState {
  final SignupStatus signupStatus;
  final BaseFailure failure;
  final bool isPasswordHidden;
  final bool isAutoValidate;

  SignupState({
    required this.signupStatus,
    required this.isPasswordHidden,
    required this.isAutoValidate,
    required this.failure,
  });

  factory SignupState.initial() {
    return SignupState(signupStatus: SignupStatus.none,isPasswordHidden: true,
      isAutoValidate: false,failure: const BaseFailure(),);
  }

  @override
  String toString() => 'UserState(userStatus: $signupStatus)';

  SignupState copyWith({
    SignupStatus? signupStatus,
    bool? isPasswordVisible,
    bool? isAutoValidate,
    BaseFailure? failure,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      isPasswordHidden: isPasswordVisible ?? isPasswordHidden,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
      failure: failure ?? this.failure,
    );
  }
}