import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/custom_appbar.dart';
import 'package:goddessmembership/config/routes/nav_router.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:goddessmembership/module/post/pages/post_screen.dart';

import '../../../components/custom_textfield.dart';
import '../../../components/loading_indicator.dart';
import '../../../components/text_view.dart';
import '../../../core/di/service_locator.dart';
import '../cubit/category_cubit.dart';
import '../cubit/category_state.dart';
import 'widget/category_tile.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isSearchEnable = false;
  TextEditingController searchEditingController = TextEditingController();

  AuthRepository _repository = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoddessCategoryCubit(sl())..fetchCategories(),
      child: BaseScaffold(
          backgroundColor: AppColors.backgroundColor,
          hMargin: 0,
          appBar: const CustomAppbar(
            'Explore',
            centerTitle: true,
            hasBackIcon: false,
          ),
          body: BlocBuilder<GoddessCategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state.categoryStatus == CategoryStatus.loading) {
                return Center(
                  child: LoadingIndicator(),
                );
              }
              if (state.categoryStatus == CategoryStatus.success) {
                print("User Id ${_repository.user.id}");
                return Column(
                  children: [
                    Container(
                      height: 1,
                      color: AppColors.primaryLight1,
                    ),
                    Container(
                      color: AppColors.searchBarColor,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              bottomMargin: 0,
                              controller: searchEditingController,
                              fillColor: AppColors.whiteColor,
                              hintText: 'Search',
                              verticalPadding: 11,
                              horizontalPadding: 11,
                              onChange: (value) {
                                setState(
                                  () {
                                    context.read<GoddessCategoryCubit>().filterSearchResults(value);
                                    if (value.isNotEmpty) {
                                      isSearchEnable = true;
                                    } else {
                                      isSearchEnable = false;
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          if (isSearchEnable)
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 14,
                                ),
                                child: TextView(
                                  'Cancel',
                                  color: AppColors.primaryDark3,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  isSearchEnable = !isSearchEnable;
                                  searchEditingController.text = "";
                                  context.read<GoddessCategoryCubit>().filterSearchResults("");
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          itemCount: state.categoriesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            String itemName = state.categoriesList[index].name;
                            return GestureDetector(
                              child: CategoryTile(goddessItemName: itemName),
                              onTap: () {
                                NavRouter.push(context,
                                    PostsScreen(pageTitle: itemName, categoryId: state.categoriesList[index].id, hasBackIcon: true,),);
                              },
                            );
                          }),
                    )),
                  ],
                );
              }
              if (state.categoryStatus == CategoryStatus.failure) {
                return Center(
                  child: Text(state.failure.message),
                );
              }
              return SizedBox();
            },
          )),
    );
  }
}
