import 'dart:async';

import 'package:flutter/material.dart';

import 'restaurant_list_page.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      Navigator.pushReplacementNamed(context, RestaurantListPage.routeName);
    });

    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/icon.png',
                scale: 2.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Text(
              'Restaurian',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
