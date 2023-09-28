import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/module/auth/repo/auth_repository.dart';
import 'package:goddessmembership/module/users_list/cubit/users_list_cubit.dart';
import 'package:goddessmembership/module/users_list/widgets/users_list_tile.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/loading_indicator.dart';
import '../../../constants/app_colors.dart';
import '../../../core/di/service_locator.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  AuthRepository _repository = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersListCubit(sl())..fetchAllUsers(),
      child: BaseScaffold(
        appBar: CustomAppbar(
          "Users",
          centerTitle: true,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: BlocBuilder<UsersListCubit, UsersListState>(
          builder: (context, state) {
            if (state.usersListStatus == UsersListStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }
            if (state.usersListStatus == UsersListStatus.success) {
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: AppColors.primaryLight1,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(state.users[index].id);
                            if (state.users[index].id != _repository.user.id) {
                              return UsersListTile(
                                user: state.users[index],
                              );
                            }
                            return Container();
                          }),
                    ),
                  ),
                ],
              );
            }

            if (state.usersListStatus == UsersListStatus.failure) {
              return Center(
                child: Text(state.failure.message),
              );
            }
            return SizedBox();
          },
        ),
        hMargin: 0,
      ),
    );
  }
}
