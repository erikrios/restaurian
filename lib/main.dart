import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurian/common/navigation.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/data/api/api_service.dart';
import 'package:restaurian/data/db/database_helper.dart';
import 'package:restaurian/data/preferences/preferences_helper.dart';
import 'package:restaurian/provider/database_provider.dart';
import 'package:restaurian/provider/preferences_provider.dart';
import 'package:restaurian/provider/restaurant_detail_provider.dart';
import 'package:restaurian/provider/restaurants_provider.dart';
import 'package:restaurian/provider/restaurants_search_provider.dart';
import 'package:restaurian/provider/scheduling_provider.dart';
import 'package:restaurian/ui/restaurant_details_page.dart';
import 'package:restaurian/ui/restaurant_favorites_page.dart';
import 'package:restaurian/ui/restaurant_list_page.dart';
import 'package:restaurian/ui/restaurant_search_page.dart';
import 'package:restaurian/ui/settings_page.dart';
import 'package:restaurian/ui/splash_screen_page.dart';
import 'package:restaurian/utils/background_service.dart';
import 'package:restaurian/utils/notification_helper.dart';
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

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiService _apiService = ApiService();
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailsPage.routeName);
    super.initState();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantsProvider>(
            create: (_) => RestaurantsProvider(
              apiService: _apiService,
            ),
          ),
          ChangeNotifierProvider<RestaurantDetailProvider>(
            create: (_) => RestaurantDetailProvider(
              apiService: _apiService,
            ),
          ),
          ChangeNotifierProvider<RestaurantSearchProvider>(
            create: (_) => RestaurantSearchProvider(
              apiService: _apiService,
            ),
          ),
          ChangeNotifierProvider<DatabaseProvider>(
            create: (_) => DatabaseProvider(
              databaseHelper: DatabaseHelper(),
            ),
          ),
          ChangeNotifierProvider<PreferencesProvider>(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Restaurian',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: myTextTheme,
            appBarTheme: AppBarTheme(
              titleTextStyle: myTextTheme.headline6,
            ),
          ),
          navigatorKey: navigatorKey,
          initialRoute: SplashScreenPage.routeName,
          routes: {
            SplashScreenPage.routeName: (context) => const SplashScreenPage(),
            RestaurantListPage.routeName: (context) =>
                const RestaurantListPage(),
            RestaurantDetailsPage.routeName: (context) => RestaurantDetailsPage(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
            RestaurantSearchPage.routeName: (context) =>
                const RestaurantSearchPage(),
            RestaurantFavoritePage.routeName: (context) =>
                const RestaurantFavoritePage(),
            SettingsPage.routeName: (context) => const SettingsPage(),
          },
        ),
      );
}
