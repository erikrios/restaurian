import 'package:restaurian/data/model/category.dart';
import 'package:restaurian/data/model/customer_review.dart';
import 'package:restaurian/utils/constant.dart';

import 'menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final num rating;
  final Menu menus;
  final List<Category> categories;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.menus,
    required this.categories,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final String id = json['id'];
    final String name = json['name'];
    final String description = json['description'];
    final String pictureId = json['pictureId'];
    final String city = json['city'];
    final String address = json['address'] ?? "";
    final num rating = json['rating'];
    final Menu menus = json['menus'] != null
        ? Menu.fromJson(json['menus'])
        : Menu(foods: [], drinks: []);
    final List<Category> categories = json['categories'] != null
        ? (json['categories'] as List)
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList()
        : [];
    final List<CustomerReview> customerReviews = json['customerReviews'] != null
        ? (json['customerReviews'] as List)
            .map((customerReviewJson) =>
                CustomerReview.fromJson(customerReviewJson))
            .toList()
        : [];

    return Restaurant(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      address: address,
      rating: rating,
      menus: menus,
      categories: categories,
      customerReviews: customerReviews,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "address": address,
        "rating": rating,
        "menus": '{foods: [], drinks: []}',
        "categories": '[]',
        "customerReviews": '[]',
      };

  String get smallPictureUrl => '$baseUrl/images/small/$pictureId';

  String get mediumPictureUrl => '$baseUrl/images/medium/$pictureId';

  String get largePictureUrl => '$baseUrl/images/large/$pictureId';
}
