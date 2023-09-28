import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/search/models/seach_response.dart';
import 'package:goddessmembership/module/search/repo/search_post_repo.dart';

import '../../../core/failures/base_failures/base_failure.dart';
import '../../../core/failures/high_priority_failure.dart';

part 'search_posts_state.dart';

class SearchPostsCubit extends Cubit<SearchPostsState> {
  SearchPostsCubit(this._repository) : super(SearchPostsState.initial());
  SearchPostRepository _repository;
  List<SearchPostModel> filterSearchPostList = [];
  List<SearchPostModel> searchPostList = [];

  Future fetchSearchPosts() async {
    emit(state.copyWith(searchPostsStatus: SearchPostsStatus.loading));

    try {
      List<SearchPostModel> response = await _repository.getSearchPosts();

      if (response.isNotEmpty) {
        filterSearchPostList =response;
        searchPostList = response;
        emit(state.copyWith(
          searchPostsStatus: SearchPostsStatus.success,
          searchPosts: response,
        ));
      } else {
        emit(state.copyWith(
            searchPostsStatus: SearchPostsStatus.failure,
            failure: HighPriorityException("Data not found...")));
      }
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          searchPostsStatus: SearchPostsStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }

  void filterSearchResults(String query) {
    filterSearchPostList = searchPostList
        .where((item) => item.title
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();
    emit(state.copyWith(
      searchPostsStatus: SearchPostsStatus.success,
      searchPosts: filterSearchPostList,
    ));
  }
}
