import 'package:restaurian/data/model/restaurant.dart';

class RestaurantSearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'];
    final int founded = json['founded'];
    final List<Restaurant> restaurants = (json['restaurants'] as List)
        .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return RestaurantSearchResponse(
      error: error,
      founded: founded,
      restaurants: restaurants,
    );
  }
}
