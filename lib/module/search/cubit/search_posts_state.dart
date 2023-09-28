part of 'search_posts_cubit.dart';

enum SearchPostsStatus {
  none,
  loading,
  success,
  failure,
}

class SearchPostsState {
  final BaseFailure failure;
  final List<SearchPostModel> searchPosts;
  final SearchPostsStatus searchPostsStatus;


  SearchPostsState({required this.failure,required this.searchPosts,required this.searchPostsStatus});

  factory SearchPostsState.initial() {
    return SearchPostsState(
      searchPostsStatus: SearchPostsStatus.none,
      failure: const BaseFailure(),
      searchPosts: [],
    );
  }

  SearchPostsState copyWith({
    SearchPostsStatus? searchPostsStatus,
    BaseFailure? failure,
    List<SearchPostModel>? searchPosts,
  }) {
    return SearchPostsState(
      searchPostsStatus: searchPostsStatus ?? this.searchPostsStatus,
      failure: failure ?? this.failure,
      searchPosts: searchPosts ?? this.searchPosts,
    );
  }
}
