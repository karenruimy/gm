import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:goddessmembership/module/membership/models/recent_membership_response.dart';
import 'package:goddessmembership/module/membership/models/user_membership_level.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/keys.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/failures/base_failures/base_failure.dart';
import '../../../core/network_service/network_service.dart';
import '../../../core/storage_service/storage_service.dart';
import '../models/levels_response.dart';

class MembershipRepository {
  final NetworkService _networkService = sl<NetworkService>();
  final StorageService _storageService = sl<StorageService>();

  Future<List<RecentMembershipModel>> getRecentMemberships() async {
    try {
      var response = await _networkService.get(Endpoints.getRecentMemberships);

      List<RecentMembershipModel> posts =
          await recentMembershipModelFromJson(response);

      return posts;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<MembershipLevelModel> getMembershipLevel(String levelId) async {
    try {
      var response = await _networkService.get(
          Endpoints.getLevels + "?id=" + levelId.toString(),
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsIm5hbWUiOiJzdXBlcnVzZXIiLCJpYXQiOjE2OTQ2MDM0NTUsImV4cCI6MTg1MjI4MzQ1NX0.d7QSY-6Oz46KS8qYDu3ER50gLIkgC7JgsxFAgwyPM_k',
            },
          ));
      MembershipLevelModel levelModel = await levelsModelFromJson(response);
      saveCategoriesIds(levelModel.categories);
      return levelModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<List<UserMembershipLevelModel>> getMembershipLevelForUser(
      String userId) async {
    try {
      var response = await _networkService
          .get(Endpoints.getLevelForUser + "?user_id=" + userId.toString(), options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsIm5hbWUiOiJzdXBlcnVzZXIiLCJpYXQiOjE2OTQ2MDM0NTUsImV4cCI6MTg1MjI4MzQ1NX0.d7QSY-6Oz46KS8qYDu3ER50gLIkgC7JgsxFAgwyPM_k',
        },
      ));
      List<UserMembershipLevelModel> userMembershipLevels =
          await userMembershipLevelModelFromJson(response);
      return userMembershipLevels;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<void> saveCategoriesIds(List<int> categories) async {
    List<String> stringsList = categories.map((i) => i.toString()).toList();
    await _storageService.setStringList(StorageKeys.categoriesIds, stringsList);
  }

  List<int> getCategoriesIds() {
    final List<String> mList =
        _storageService.getStringList(StorageKeys.categoriesIds) ?? [];
    List<int> list = mList.map((e)=>int.parse(e)).toList();
    return list;
  }
}
