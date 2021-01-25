import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restofl/common/navigation.dart';
import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/preferences/preferences_helper.dart';
import 'package:restofl/provider/preferences_provider.dart';
import 'package:restofl/provider/restaurant_provider.dart';
import 'package:restofl/provider/scheduling_provider.dart';
import 'package:restofl/provider/search_provider.dart';
import 'package:restofl/ui/splashscreen/splashscreen_page.dart';
import 'package:restofl/ui/home/home_page.dart';
import 'package:restofl/ui/detail/resto_detail_page.dart';
import 'package:restofl/utils/background_service.dart';
import 'package:restofl/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        /* ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ), */
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'RestoFL',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: SplashScreenPage.routeName,
            routes: {
              SplashScreenPage.routeName: (context) => SplashScreenPage(),
              HomePage.routeName: (context) => HomePage(),
              RestoDetailPage.routeName: (context) => RestoDetailPage(
                    restaurant: ModalRoute.of(context).settings.arguments,
                  ),
            },
          );
        },
      ),
    );
  }
}
