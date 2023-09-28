import 'dart:developer';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/failures/base_failures/base_failure.dart';
import '../../../core/network_service/network_service.dart';
import '../models/categories_response.dart';

class CategoryRepository {
  final NetworkService _networkService = sl<NetworkService>();

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await _networkService.get(Endpoints.getCategories);

      List<CategoryModel> categoryResponseModel =
          await categoryResponseModelFromJson(response);

      return categoryResponseModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
