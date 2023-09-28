import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goddessmembership/components/base_scaffold.dart';
import 'package:goddessmembership/constants/app_colors.dart';
import 'package:goddessmembership/module/splash/startup_screen.dart';
import 'package:goddessmembership/module/splash/welcome_screen.dart';
import 'package:lottie/lottie.dart';

import '../../config/routes/nav_router.dart';
import '../../core/di/service_locator.dart';
import '../auth/repo/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AuthRepository repository = AuthRepository(sl(), sl());
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage("assets/images/jpg/sign_up_login_top_image.jpg"), context);
    super.didChangeDependencies();
  }

  void isAuthenticated() async {
    bool isAuthenticate = await repository.isAuthenticated();
    if (isAuthenticate) {
      await repository.initUserAppSession();
      NavRouter.pushReplacement(context, StartupScreen());
    } else {
      NavRouter.pushReplacement(context, WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteColor,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    return BaseScaffold(
        hMargin: 0,
        body: Center(
          child: Lottie.asset(
            'animations/splash.json',
            height: MediaQuery
                .sizeOf(context)
                .height,
            width: MediaQuery
                .sizeOf(context)
                .width,
            fit: BoxFit.cover,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(() => {
                isAuthenticated()
                });
            },
          ),
        ));
  }
}
