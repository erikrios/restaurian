import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/provider/database_provider.dart';
import 'package:restaurian/utils/result_state.dart';
import 'package:restaurian/widget/custom_list.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({Key? key}) : super(key: key);

  static const routeName = '/restaurants/favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: SafeArea(
        child: Consumer<DatabaseProvider>(
          builder: (context, provider, _) {
            ResultState<List<Restaurant>> state = provider.restaurantsState;
            switch (state.status) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    child: Text(
                      state.message!,
                    ),
                  ),
                );
              case Status.hasData:
                {
                  List<Restaurant> restaurants = state.data ?? [];
                  if (restaurants.isEmpty) {
                    return const Center(
                      child: Text('Restaurant is empty.'),
                    );
                  } else {
                    return CustomList(
                      restaurants: restaurants,
                    );
                  }
                }
            }
          },
        ),
      ),
    );
  }
}
