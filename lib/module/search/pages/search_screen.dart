import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/components/custom_textfield.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/search/cubit/search_posts_cubit.dart';
import 'package:goddessmembership/module/search/pages/widget/search_tile.dart';

import '../../../components/loading_indicator.dart';
import '../../../core/di/service_locator.dart';
import '../models/seach_response.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  bool isSearchEnable = false;
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPostsCubit(sl())..fetchSearchPosts(),
      child: BaseScaffold(
        hMargin: 0,
        appBar: const CustomAppbar(
          'Search',
          centerTitle: true,
          hasBackIcon: false,

        ),
        body: BlocBuilder<SearchPostsCubit, SearchPostsState>(
          builder: (context, state) {

            if (state.searchPostsStatus == SearchPostsStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }

            if(state.searchPostsStatus == SearchPostsStatus.success){
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: AppColors.primaryLight1,
                  ),
                  Container(
                    color: AppColors.primaryLight1,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                              height: 38,
                              controller: searchEditingController,
                              fillColor: AppColors.whiteColor,
                              hintText: '',
                              onChange: (value) {
                                context.read<SearchPostsCubit>().filterSearchResults(value);
                                setState(() {
                                  if (value.isNotEmpty) {
                                    isSearchEnable = true;
                                  } else {
                                    isSearchEnable = false;
                                  }
                                });
                              },
                            )),
                        if (isSearchEnable)
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 18,
                              ),
                              child: TextView(
                                'Cancel',
                                color: AppColors.primaryDark3,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                isSearchEnable = !isSearchEnable;
                                searchEditingController.text = "";
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      width: double.infinity,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.searchPosts.length,
                          itemBuilder: (BuildContext context, int index) {
                            SearchPostModel searchPost = state.searchPosts[index];
                            return GestureDetector(
                              child: SearchTile(
                                searchModel: searchPost,
                              ),
                              onTap: () {},
                            );
                          }),
                    ),
                  ),
                ],
              );
            }

            if (state.searchPostsStatus == SearchPostsStatus.failure) {
              return Center(
                child: Text(state.failure.message),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
