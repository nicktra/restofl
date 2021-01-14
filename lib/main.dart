import 'package:flutter/material.dart';
import 'package:restofl/ui/splashscreen/splashscreen_page.dart';
import 'package:restofl/ui/home/home_page.dart';
import 'package:restofl/ui/detail/resto_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestoFL',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
