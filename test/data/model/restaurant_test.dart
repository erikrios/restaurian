import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurian/data/model/restaurant.dart';

import 'dummy.dart';

void main() {
  group('JSON Parsing Test', () {
    late String restaurantJsonOne;
    late Restaurant expectedRestaurantOne;

    late Restaurant restaurantTwo;
    late String expectedJsonTwo;

    setUp(() {
      restaurantJsonOne = dummyRestaurantJsonOne;
      expectedRestaurantOne = dummyRestaurantOne;

      restaurantTwo = dummyRestaurantTwo;
      expectedJsonTwo = dummyRestaurantJsonTwo;
    });

    test('should return correct restaurant data when parsing from json', () {
      Restaurant restaurant =
          Restaurant.fromJson(jsonDecode(restaurantJsonOne));

      expect(restaurant.id, expectedRestaurantOne.id);
      expect(restaurant.name, expectedRestaurantOne.name);
      expect(restaurant.description, expectedRestaurantOne.description);
      expect(restaurant.pictureId, expectedRestaurantOne.pictureId);
      expect(restaurant.city, expectedRestaurantOne.city);
      expect(restaurant.address, expectedRestaurantOne.address);
      expect(restaurant.rating, expectedRestaurantOne.rating);
      expect(restaurant.menus.foods.length,
          expectedRestaurantOne.menus.foods.length);
      expect(restaurant.menus.drinks.length,
          expectedRestaurantOne.menus.drinks.length);
      expect(restaurant.categories.length,
          expectedRestaurantOne.categories.length);
      expect(restaurant.customerReviews.length,
          expectedRestaurantOne.customerReviews.length);
    });

    test('should return correct json when encode to json', () {
      String json = jsonEncode(restaurantTwo.toJson());
      expect(json, expectedJsonTwo);
    });
  });
}
