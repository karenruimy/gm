import 'package:bloc/bloc.dart';
import 'package:goddessmembership/module/post/models/posts_response.dart';
import 'package:goddessmembership/module/post/repo/posts_repo.dart';

import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._repository) : super(PostsState.initial());
  PostsRepository _repository;

  Future fetchPosts(int categoryId) async {
    emit(state.copyWith(postsStatus: PostsStatus.loading));

    try {
      List<PostModel> response = await _repository.getPosts(categoryId);
      if (response.isNotEmpty) {
        emit(state.copyWith(
          postsStatus: PostsStatus.success,
          posts: response,
        ));
      } else {
        emit(state.copyWith(
            postsStatus: PostsStatus.failure,
            failure: HighPriorityException("Data not found...")));
      }
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          postsStatus: PostsStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
  }
}
