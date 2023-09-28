import 'package:flutter/material.dart';
import 'package:goddessmembership/module/auth/cubit/user_cubit/user_cubit.dart';

import 'core/initializers/init_firebase.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/app_bloc_observer.dart';
import 'core/di/service_locator.dart';
import 'config/flavors/flavors.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';

import 'module/auth/cubit/auth_cubit/auth_cubit.dart';
import 'module/auth/cubit/signup_cubit/signup_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies(AppEnv.dev);
  await sl.allReady();
  await initApp();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(sl())),
        BlocProvider<UserCubit>(create: (_) => UserCubit(sl())),
        BlocProvider<SignupCubit>(create: (_) => SignupCubit(sl())),
      ],
      child: const App(),
    ),
  );
}
