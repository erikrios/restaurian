import 'package:restaurian/data/model/restaurant.dart';

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'];
    final String message = json['message'];
    final Restaurant restaurant = Restaurant.fromJson(json['restaurant']);

    return RestaurantDetailResponse(
      error: error,
      message: message,
      restaurant: restaurant,
    );
  }
}
