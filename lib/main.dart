import 'package:flutter/material.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/ui/restaurant_list_page.dart';
import 'package:restaurian/ui/splash_screen_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Restaurian',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            titleTextStyle: myTextTheme.headline6,
          ),
        ),
        initialRoute: SplashScreenPage.routeName,
        routes: {
          SplashScreenPage.routeName: (BuildContext context) =>
              const SplashScreenPage(),
          RestaurantListPage.routeName: (BuildContext context) =>
              const RestaurantListPage(),
        },
      );
}
