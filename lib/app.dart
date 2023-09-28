import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:goddessmembership/module/splash/splash_screen.dart';
import 'components/unfocus.dart';
import 'config/routes/nav_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Karen Ruimy',
      navigatorKey: NavRouter.navigationKey,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        child = BotToastInit()(context, child);
        child = UnFocus(child: child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      home: SplashScreen(),
    );
  }

}