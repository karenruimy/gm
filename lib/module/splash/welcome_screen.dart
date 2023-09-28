import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/module/auth/pages/login_page.dart';
import 'package:goddessmembership/module/auth/pages/signup_page.dart';
import 'package:goddessmembership/module/splash/splash_cubit.dart';
import 'package:goddessmembership/module/splash/startup_screen.dart';

import '../../components/custom_button.dart';
import '../../components/text_view.dart';
import '../../config/routes/nav_router.dart';
import '../../constants/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryDark,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    return BaseScaffold(
        hMargin: 0,
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/jpg/sign_up_login_top_image.jpg", height: 250,fit: BoxFit.cover,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60,),
                    Center(
                      child: TextView(
                        'Welcome to\nThe Goddess Membership',
                        color: AppColors.blackColor,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 30 ,),
                    Center(
                      child: TextView(
                        'Create an account to embark on your\nSpiritual Journey!',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        height: 1.5,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      height: 50,
                      backgroundColor: AppColors.primaryDark,
                      borderRadius: 8,
                      onPressed: () {
                        NavRouter.pushReplacement(
                            context, SignUpScreen());
                      },
                      title: 'Sign Up',
                      fontSize: 18,
                      textColor: AppColors.whiteColor,
                      isEnabled: true,
                    ),
                    SizedBox(height: 70),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            "Already have an account?",
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          TextButton(
                              onPressed: () {
                                NavRouter.pushReplacement(
                                    context, LoginScreen());
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
            ],
          ),
        ));
  }
}
