import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/post/cubit/post_list_cubit/posts_cubit.dart';
import 'package:goddessmembership/module/post/pages/post_detail_screen.dart';

import '../../../components/loading_indicator.dart';
import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../membership/repo/membership_repo.dart';
import '../models/posts_response.dart';
import 'widget/post_tile.dart';

class PostsScreen extends StatefulWidget {
  final String pageTitle;
  final int categoryId;
  final hasBackIcon;

  const PostsScreen({super.key, required this.pageTitle, required this.categoryId, required this.hasBackIcon});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final MembershipRepository _membershipRepository = sl<MembershipRepository>();

  bool isMembershipAvailable(PostModel postModel) {
    if (_membershipRepository.getCategoriesIds().isEmpty) {
      return false;
    } else {
      List<int>? matchingItems =
          _membershipRepository.getCategoriesIds().where((item) => postModel.categories.contains(item)).toList();
      if (matchingItems.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(sl())..fetchPosts(widget.categoryId),
      child: BaseScaffold(
        hMargin: 0,
        backgroundColor: AppColors.backgroundColor,
        body: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state.postsStatus == PostsStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }

            if (state.postsStatus == PostsStatus.success) {
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: AppColors.primaryLight1,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: state.posts.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          PostModel postModel = state.posts[index];
                          return GestureDetector(
                            onTap: () {
                              if (isMembershipAvailable(postModel)) {
                                NavRouter.push(
                                    context,
                                    PostDetailScreen(
                                      postModel: postModel,
                                      pageTitle: postModel.title.rendered,
                                    ));
                              }
                            },
                            child: PostTile(postModel: postModel),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state.postsStatus == PostsStatus.failure) {
              return Center(
                child: Text(state.failure.message),
              );
            }
            return SizedBox();
          },
        ),
        appBar: CustomAppbar(
          widget.pageTitle.replaceAll('&amp;', '\u0026'),
          hasBackIcon: widget.hasBackIcon,
          centerTitle: true,
        ),
      ),
    );
  }
}
