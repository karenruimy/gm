import 'package:bloc/bloc.dart';

import '../../../core/failures/base_failures/base_failure.dart';
import '../../../core/failures/high_priority_failure.dart';
import '../models/categories_response.dart';
import '../repo/category_repo.dart';
import 'category_state.dart';

class GoddessCategoryCubit extends Cubit<CategoryState> {
  GoddessCategoryCubit(this._repository)
      : super(CategoryState.initial());

  CategoryRepository _repository;
  List<CategoryModel> filteredList = [];
  List<CategoryModel> categoriesList = [];


  Future fetchCategories() async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));

    try {
      List<CategoryModel> response = await _repository.getCategories();
      response.removeWhere((item) => item.name == 'Webinars');
      if (response.isNotEmpty) {
        filteredList = response;
        categoriesList = response;
        emit(state.copyWith(
          categoryStatus: CategoryStatus.success,
          categoriesList: response,
        ));
      } else {
        emit(state.copyWith(
            categoryStatus: CategoryStatus.failure,
            failure: HighPriorityException("Data not found...")));
      }
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          categoryStatus: CategoryStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }

  void filterSearchResults(String query) {
    filteredList = categoriesList
        .where((item) => item.name
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();
    emit(state.copyWith(
      categoryStatus: CategoryStatus.success,
      categoriesList: filteredList,
    ));
  }
}
