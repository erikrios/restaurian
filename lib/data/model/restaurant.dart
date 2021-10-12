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
    String id = json['id'];
    String name = json['name'];
    String description = json['description'];
    String pictureId = json['pictureId'];
    String city = json['city'];
    String address = json['address'] ?? "";
    num rating = json['rating'];
    Menu menus = json['menus'] != null
        ? Menu.fromJson(json['menus'])
        : Menu(foods: [], drinks: []);
    List<Category> categories = json['categories'] != null
        ? (json['categories'] as List)
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList()
        : [];
    List<CustomerReview> customerReviews = json['customerReviews'] != null
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

  get smallPictureUrl => '$baseUrl/images/small/$pictureId';

  get mediumPictureUrl => '$baseUrl/images/medium/$pictureId';

  get largePictureUrl => '$baseUrl/images/large/$pictureId';
}
