


import 'dart:developer';

import 'package:goddessmembership/module/search/models/seach_response.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/failures/base_failures/base_failure.dart';
import '../../../core/network_service/network_service.dart';

class SearchPostRepository{
  final NetworkService _networkService = sl<NetworkService>();

  Future<List<SearchPostModel>> getSearchPosts() async {

    try {

      var response = await _networkService.get(
          Endpoints.search
      );

      List<SearchPostModel> searchPosts = await searchPostModelFromJson(response);

      return searchPosts;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}