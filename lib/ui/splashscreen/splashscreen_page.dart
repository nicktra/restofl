import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restofl/ui/home/home_page.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splashscreen_page';

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/icon/icon.png',
        splashIconSize: 256,
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Color(0xfffff176));
  }
}
