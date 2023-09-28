import 'dart:developer';

import 'package:goddessmembership/module/post/models/posts_response.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/failures/base_failures/base_failure.dart';
import '../../../core/network_service/network_service.dart';

class PostsRepository{
  final NetworkService _networkService = sl<NetworkService>();

  Future<List<PostModel>> getPosts(int categoryId) async {

    try {

      var response = await _networkService.get(
          Endpoints.getPosts+"?categories="+categoryId.toString()
      );

      List<PostModel> posts =  await postsResponseModelFromJson(response);

      return posts;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<PostModel> getPostDetail(int postId) async {

    try {
      var response = await _networkService.get(
          Endpoints.getPosts+"/"+postId.toString()
      );

      PostModel posts = await postModelFromJson(response);

      return posts;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}