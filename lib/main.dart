import 'package:flutter/material.dart';
import 'package:restofl/ui/splashscreen/splashscreen_page.dart';
import 'package:restofl/ui/home/home_page.dart';
import 'package:restofl/ui/detail/resto_detail_page.dart';
import 'package:restofl/common/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestoFL',
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        appBarTheme: AppBarTheme(
          textTheme: myTextTheme.apply(bodyColor: Colors.black),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        primaryColor: primaryColor2,
        accentColor: secondaryColor2,
        appBarTheme: AppBarTheme(
          textTheme: myTextTheme.apply(bodyColor: Colors.white),
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => SplashScreenPage(),
        HomePage.routeName: (context) => HomePage(),
        RestoDetailPage.routeName: (context) => RestoDetailPage(
              resto: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
