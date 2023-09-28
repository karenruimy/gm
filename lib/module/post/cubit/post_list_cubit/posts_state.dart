part of 'posts_cubit.dart';

enum PostsStatus {
  none,
  loading,
  success,
  failure,
}

class PostsState {
  final BaseFailure failure;
  final List<PostModel> posts;
  final PostsStatus postsStatus;

  PostsState(
      {required this.failure, required this.posts, required this.postsStatus});

  factory PostsState.initial() {
    return PostsState(
      postsStatus: PostsStatus.none,
      failure: const BaseFailure(),
      posts: [],
    );
  }

  PostsState copyWith({
    PostsStatus? postsStatus,
    BaseFailure? failure,
    List<PostModel>? posts,
  }) {
    return PostsState(
      postsStatus: postsStatus ?? this.postsStatus,
      failure: failure ?? this.failure,
      posts: posts ?? this.posts,
    );
  }
}
