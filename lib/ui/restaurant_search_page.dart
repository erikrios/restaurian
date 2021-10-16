import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/data/model/restaurant_search_response.dart';
import 'package:restaurian/provider/restaurants_search_provider.dart';
import 'package:restaurian/utils/result_state.dart';
import 'package:restaurian/widget/custom_list.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurants/search';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer? _debounce;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 8.0,
                  ),
                  label: Text(
                    'Search',
                  ),
                  hintText: 'Input the restaurant name or menu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                ),
                onChanged: (text) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    if (text.isNotEmpty) {
                      RestaurantSearchProvider provider =
                          Provider.of<RestaurantSearchProvider>(
                        context,
                        listen: false,
                      );
                      provider.searchRestaurant(text);
                    }
                  });
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, _) {
                ResultState<RestaurantSearchResponse> state = provider.state;
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
                      {
                        List<Restaurant> restaurants = state.data!.restaurants;
                        if (restaurants.isEmpty) {
                          return const Center(
                            child: Text('The search result is empty.'),
                          );
                        } else {
                          return CustomList(
                            restaurants: restaurants,
                          );
                        }
                      }
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
