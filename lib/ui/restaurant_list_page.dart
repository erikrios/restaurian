import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/data/model/restaurant_list_response.dart';
import 'package:restaurian/provider/restaurants_provider.dart';
import 'package:restaurian/provider/result_state.dart';
import 'package:restaurian/widget/custom_list.dart';

import 'restaurant_search_page.dart';

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
            child: Text(
              'Recommended restaurant for you!',
              style: myTextTheme.subtitle2!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(10.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RestaurantSearchPage.routeName,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<RestaurantsProvider>(
        builder: (context, provider, _) {
          ResultState<RestaurantListResponse> state = provider.state;
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
                List<Restaurant> restaurants = state.data!.restaurants;
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
    );
  }
}
