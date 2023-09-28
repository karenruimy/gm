

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../models/posts_response.dart';

enum PostDetailStatus {
  none,
  loading,
  success,
  failure,
}

class PostDetailState {
  final BaseFailure failure;
  final PostModel? post;
  final PostDetailStatus postStatus;

  PostDetailState(
      {required this.failure, required this.post,  required this.postStatus});

  factory PostDetailState.initial() {
    return PostDetailState(
      postStatus: PostDetailStatus.none,
      failure: const BaseFailure(),
      post: null
    );
  }

  PostDetailState copyWith({
    PostDetailStatus? postStatus,
    BaseFailure? failure,
    PostModel? post,
  }) {
    return PostDetailState(
      postStatus: postStatus ?? this.postStatus,
      failure: failure ?? this.failure,
      post: post ?? this.post,
    );
  }
}