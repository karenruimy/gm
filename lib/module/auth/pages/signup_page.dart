import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/module/auth/cubit/signup_cubit/signup_cubit.dart';
import 'package:goddessmembership/module/auth/cubit/signup_cubit/signup_state.dart';
import 'package:goddessmembership/module/auth/pages/login_page.dart';

import '../../../components/base_scaffold.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/text_view.dart';
import '../../../config/routes/nav_router.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/display/display_utils.dart';
import '../../../utils/validators/validation_utils.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../widget/password_suffix_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void _onSignUpButtonPressed() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      SignupInput input = SignupInput(
        username: usernameController.text.trim(),
        firstname: firstNameController.text.trim(),
        lastname: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      context.read<SignupCubit>().signup(input);
    } else {
      context.read<SignupCubit>().enableAutoValidateMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryDark,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.signupStatus == SignupStatus.loading) {
          DisplayUtils.showLoader();
        }
        if (state.signupStatus == SignupStatus.userSuccess) {
          DisplayUtils.removeLoader();
          DisplayUtils.showSnackBar(context, "User Created Successfully!");
          NavRouter.pushReplacement(context, LoginScreen());
        }
        if (state.signupStatus == SignupStatus.failure) {
          DisplayUtils.removeLoader();
          DisplayUtils.showSnackBar(context, state.failure.message);
        }
      },
      builder: (context, state) {
        return BaseScaffold(
            hMargin: 0,
            backgroundColor: AppColors.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/jpg/sign_up_login_top_image.jpg",
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: TextView(
                              'Create An Account',
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
                            onValidate: (val) => ValidationUtils.validateUserName(val),
                          ),
                          CustomTextField(
                            hintText: 'First Name',
                            controller: firstNameController,
                            inputType: TextInputType.text,
                            fillColor: AppColors.textFieldColor,
                            onValidate: (val) => ValidationUtils.validateUserName(val),
                          ),
                          CustomTextField(
                            hintText: 'Last Name',
                            controller: lastNameController,
                            inputType: TextInputType.text,
                            fillColor: AppColors.textFieldColor,
                            onValidate: (val) => ValidationUtils.validateUserName(val),
                          ),
                          CustomTextField(
                            hintText: 'Email',
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            fillColor: AppColors.textFieldColor,
                            onValidate: (val) => ValidationUtils.validateEmail(val),
                          ),
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: state.isPasswordHidden,
                            onValidate: (val) => ValidationUtils.validatePassword(val),
                            inputType: TextInputType.visiblePassword,
                            controller: passwordController,
                            fillColor: AppColors.textFieldColor,
                            suffixWidget: PasswordSuffixWidget(
                              isPasswordVisible: state.isPasswordHidden,
                              onTap: () {
                                context.read<SignupCubit>().toggleShowPassword();
                              },
                            ),
                          ),
                          CustomButton(
                            height: 50,
                            backgroundColor: AppColors.primaryDark,
                            borderRadius: 8,
                            fontSize: 18,
                            onPressed: () {
                              _onSignUpButtonPressed();
                            },
                            title: 'Sign Up',
                            textColor: AppColors.whiteColor,
                            isEnabled: true,
                          ),
                          SizedBox(height: 24),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextView(
                                  "Already a member?",
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                          _createRoute()
                                      );
                                    },
                                    child: TextView(
                                      'Log in',
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
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  LoginScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}