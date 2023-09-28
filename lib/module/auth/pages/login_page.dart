import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/components/text_view.dart';
import 'package:goddessmembership/config/config.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:goddessmembership/module/auth/cubit/user_cubit/user_cubit.dart';
import 'package:goddessmembership/module/auth/pages/signup_page.dart';
import 'package:goddessmembership/module/splash/startup_screen.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../../../utils/display/display_utils.dart';
import '../../../utils/validators/validation_utils.dart';
import '../widget/password_suffix_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      LoginInput loginInput = LoginInput(
        username: usernameController.text.trim(),
        password: passwordController.text,
      );
      context.read<AuthCubit>().login(loginInput);
    } else {
      context.read<AuthCubit>().enableAutoValidateMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryDark,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    return BlocListener<UserCubit, UserState>(
      listener: (context, userState) {
        if (userState.userStatus == UserStatus.loading) {
          DisplayUtils.showLoader();
        }
        if (userState.userStatus == UserStatus.userSuccess) {
          DisplayUtils.removeLoader();
          NavRouter.pushAndRemoveUntil(context, StartupScreen());
        }
        if (userState.userStatus == UserStatus.failure) {
          DisplayUtils.removeLoader();
          DisplayUtils.showSnackBar(context, userState.failure.message);
        }
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, authState) {
          if (authState.authStatus == AuthStatus.loading) {
            DisplayUtils.showLoader();
          }
          if (authState.authStatus == AuthStatus.authenticated) {
            DisplayUtils.removeLoader();
            context.read<UserCubit>().getUserProfile();
          }
          if (authState.authStatus == AuthStatus.unauthenticated) {
            DisplayUtils.removeLoader();
            DisplayUtils.showSnackBar(context, authState.failure.message);
          }
        },
        builder: (context, authState) {
          return BaseScaffold(
              hMargin: 0,
              backgroundColor: AppColors.backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/images/jpg/sign_up_login_top_image.jpg", height: 250,fit: BoxFit.cover,),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 60,),
                            Center(
                              child: TextView(
                                'Login',
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 40),
                            CustomTextField(
                              hintText: 'Username',
                              controller: usernameController,
                              inputType: TextInputType.text,
                              fillColor: AppColors.textFieldColor,
                              onValidate: (val) =>
                                  ValidationUtils.validateUserName(val),
                            ),
                            CustomTextField(
                              hintText: 'Password',
                              obscureText: authState.isPasswordHidden,
                              onValidate: (val) =>
                                  ValidationUtils.validatePassword(val),
                              inputType: TextInputType.visiblePassword,
                              controller: passwordController,
                              fillColor: AppColors.textFieldColor,
                              suffixWidget: PasswordSuffixWidget(
                                isPasswordVisible: authState.isPasswordHidden,
                                onTap: () {
                                  context.read<AuthCubit>().toggleShowPassword();
                                },
                              ),
                            ),
                            CustomButton(
                              height: 50,
                              backgroundColor: AppColors.primaryDark,
                              borderRadius: 8,
                              onPressed: () {
                                _onLoginButtonPressed();
                              },
                              title: 'Login',
                              fontSize: 18,
                              textColor: AppColors.whiteColor,
                              isEnabled: true,
                            ),
                            SizedBox(height: 24),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextView(
                                    "Don't have an account?",
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context, _createRoute());;
                                      },
                                      child: TextView(
                                        'Sign Up',
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  SignUpScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}