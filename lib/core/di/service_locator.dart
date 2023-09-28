import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:goddessmembership/module/membership/repo/membership_repo.dart';
import 'package:goddessmembership/module/search/repo/search_post_repo.dart';
import 'package:goddessmembership/module/users_list/repo/users_list_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/flavors/flavors.dart';
import '../../module/auth/repo/auth_repository.dart';
import '../../module/categories/repo/category_repo.dart';
import '../../module/post/repo/posts_repo.dart';
import '../core.dart';
import '../notifications/cloud_messaging_service.dart';
import '../notifications/local_notification_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies(AppEnv appEnv) async {
  sl.registerSingleton(Flavors()..initConfig(appEnv));
  sl.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  // modules
  sl.registerSingletonWithDependencies<StorageService>(
    () => StorageService(sl()),
    dependsOn: [SharedPreferences],
  );
  sl.registerLazySingleton<NetworkService>(
    () => NetworkService(sl(), dio: Dio()),
  );

  // notifications
  sl.registerLazySingleton<CloudMessagingService>(
      () => CloudMessagingService());
  sl.registerLazySingleton<LocalNotificationsService>(
      () => LocalNotificationsService());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl(), sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepository());
  sl.registerLazySingleton<PostsRepository>(() => PostsRepository());
  sl.registerLazySingleton<SearchPostRepository>(() => SearchPostRepository());
  sl.registerLazySingleton<UsersListRepository>(() => UsersListRepository());
  sl.registerLazySingleton<MembershipRepository>(() => MembershipRepository());
}
