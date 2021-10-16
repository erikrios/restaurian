import 'package:flutter/material.dart';
import 'package:restaurian/widget/custom_list.dart';

class RestaurantFavorite extends StatelessWidget {
  const RestaurantFavorite({Key? key}) : super(key: key);

  static const routeName = '/restaurants/favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomList(
            restaurants: [],
          ),
        ),
      ),
    );
  }
}
