import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/data/api/api_service.dart';
import 'package:restaurian/provider/restaurant_detail_provider.dart';
import 'package:restaurian/provider/restaurants_provider.dart';
import 'package:restaurian/provider/restaurants_search_provider.dart';
import 'package:restaurian/ui/restaurant_details_page.dart';
import 'package:restaurian/ui/restaurant_favorites_page.dart';
import 'package:restaurian/ui/restaurant_list_page.dart';
import 'package:restaurian/ui/restaurant_search_page.dart';
import 'package:restaurian/ui/splash_screen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ApiService _apiService = ApiService();

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
          initialRoute: SplashScreenPage.routeName,
          routes: {
            SplashScreenPage.routeName: (context) => const SplashScreenPage(),
            RestaurantListPage.routeName: (context) =>
                const RestaurantListPage(),
            RestaurantDetailsPage.routeName: (context) =>
                const RestaurantDetailsPage(),
            RestaurantSearchPage.routeName: (context) =>
                const RestaurantSearchPage(),
            RestaurantFavoritePage.routeName: (context) =>
                const RestaurantFavoritePage(),
          },
        ),
      );
}
