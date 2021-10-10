import 'package:flutter/material.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  static const routeName = '/restaurants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant',
        ),
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.only(
              left: 14.0,
              bottom: 12.0,
            ),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Recommended restaurant for you!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(10.0),
        ),
      ),
      body: const Center(
        child: Text(
          'Restaurant List Page',
        ),
      ),
    );
  }
}
