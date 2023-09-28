import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../../../core/notifications/cloud_messaging_service.dart';
import '../../models/user.dart';
import '../../repo/auth_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._authRepository) : super(UserState.initial());
  final AuthRepository _authRepository;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void getUserProfile() async {
    emit(state.copyWith(userStatus: UserStatus.loading));

    try {
      User user = await _authRepository.getUserProfile();
      if (user.id != -1) {
        String fcmToken = await sl<CloudMessagingService>().getFcmToken() ?? "";
        print("FCM Token -  :: $fcmToken");
        await storeFcmToFirebase(fcmToken, user.id.toString());
        emit(state.copyWith(userStatus: UserStatus.userSuccess));
      } else {
        emit(state.copyWith(
            userStatus: UserStatus.failure,
            failure: HighPriorityException("Authentication failed...")));
      }
    } on BaseFailure catch (e) {
      print("Base Failure --- $e");
      emit(state.copyWith(
          userStatus: UserStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      print("Catch --- $_");
      emit(state.copyWith(
          userStatus: UserStatus.failure,
          failure: HighPriorityException("Something went wrong...")));
    }
  }

  Future storeFcmToFirebase(String token, String userId) async {
    print("UserId :: $userId");
    print("FCM Token :: $token");
    await _firestore.collection('users').doc(userId).set({
      'FcmToken': token,
      'isOnline': false,
    });
  }
}
