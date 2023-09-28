

import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/post/cubit/post_detail_cubit/post_detail_state.dart';

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../models/posts_response.dart';
import '../../repo/posts_repo.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit(this._repository) : super(PostDetailState.initial());
  PostsRepository _repository;

  Future fetchPostDetail(int postId) async {
    emit(state.copyWith(postStatus: PostDetailStatus.loading));

    try {
      PostModel response = await _repository.getPostDetail(postId);
      emit(state.copyWith(
        postStatus: PostDetailStatus.success,
        post: response,
      ));
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          postStatus: PostDetailStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }

}