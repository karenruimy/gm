import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/service_locator.dart';
import '../auth/repo/auth_repository.dart';

enum SplashState {
  none, // none
  unauthenticated, // => dashboard
  authenticated, // => logged-in-dashboard
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.none);

  void init() async {
    debugPrint('splash ..init');
    AuthRepository _repo = sl<AuthRepository>();
    bool isAuthenticate = await _repo.isAuthenticated();

    if (isAuthenticate) {
      await _repo.initUserAppSession();
      emit(SplashState.authenticated);
    } else {
      emit(SplashState.unauthenticated);
    }
  }
}
