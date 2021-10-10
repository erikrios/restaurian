import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/data/model/restaurant_response.dart';
import 'package:restaurian/ui/restaurant_details_page.dart';

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
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/restaurants.json'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                if (snapshot.data == null) {
                  return _buildList(context, []);
                } else {
                  Map<String, dynamic> json = jsonDecode(snapshot.data!);
                  RestaurantResponse responses =
                      RestaurantResponse.fromJson(json);
                  List<Restaurant> restaurants = responses.restaurants;
                  return _buildList(context, restaurants);
                }
              }
            default:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
          }
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Restaurant> restaurants) {
    return ListView.separated(
      itemCount: restaurants.length,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 2.0,
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        Restaurant restaurant = restaurants[index];
        return _buildItemList(context, restaurant);
      },
    );
  }

  Widget _buildItemList(BuildContext context, Restaurant restaurant) {
    return ListTile(
      leading: Hero(
        tag: restaurant.id,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            restaurant.pictureId,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailsPage.routeName,
          arguments: restaurant,
        );
      },
      subtitle: Row(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(
                        Icons.location_on,
                        size: 15.0,
                      ),
                    ),
                    TextSpan(
                      text: restaurant.city,
                      style: myTextTheme.subtitle2!.copyWith(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    restaurant.rating < 2.0
                        ? Icons.star_outline
                        : restaurant.rating < 4.0
                            ? Icons.star_half
                            : Icons.star,
                    size: 15.0,
                  ),
                ),
                TextSpan(
                  text: restaurant.rating.toString(),
                  style: myTextTheme.subtitle2!.copyWith(
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
