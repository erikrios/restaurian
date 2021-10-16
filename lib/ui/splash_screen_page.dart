import 'dart:async';

import 'package:flutter/material.dart';

import 'restaurant_list_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  static const routeName = '/splash';

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(
      const Duration(
        seconds: 3,
      ),
      (timer) {
        Navigator.pushReplacementNamed(context, RestaurantListPage.routeName);
      },
    );

    return Scaffold(
      backgroundColor: Colors.indigo,
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
