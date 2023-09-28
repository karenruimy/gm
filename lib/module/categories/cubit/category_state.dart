
import '../../../core/failures/base_failures/base_failure.dart';
import '../models/categories_response.dart';

enum CategoryStatus {
  none,
  loading,
  success,
  failure,
}

class CategoryState {
  final CategoryStatus categoryStatus;
  final BaseFailure failure;
  final List<CategoryModel> categoriesList;

  CategoryState({
    required this.categoryStatus,
    required this.failure,
    required this.categoriesList,
  });

  factory CategoryState.initial() {
    return CategoryState(
      categoryStatus: CategoryStatus.none,
      failure: const BaseFailure(),
      categoriesList: [],
    );
  }

  CategoryState copyWith({
    CategoryStatus? categoryStatus,
    BaseFailure? failure,
    List<CategoryModel>? categoriesList,
  }) {
    return CategoryState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      failure: failure ?? this.failure,
      categoriesList: categoriesList ?? this.categoriesList,
    );
  }
}