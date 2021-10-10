import 'package:restaurian/data/model/restaurant.dart';

class RestaurantResponse {
  final List<Restaurant> restaurants;

  RestaurantResponse({required this.restaurants});

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    List<Restaurant> restaurants = (json['restaurants'] as List)
        .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return RestaurantResponse(restaurants: restaurants);
  }
}
