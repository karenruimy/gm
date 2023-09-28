import 'dart:developer';
import 'package:goddessmembership/core/core.dart';
import 'package:goddessmembership/module/auth/models/user.dart';

import '../../../constants/api_endpoints.dart';

class UsersListRepository {
  NetworkService _networkService = sl<NetworkService>();

  Future<List<User>> getUsersList() async {
    try {
      var response = await _networkService.get(
        Endpoints.getAllUsers,
      );

      List<User> users = await userListModelFromJson(response);
      return users;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
