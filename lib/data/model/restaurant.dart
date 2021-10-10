import 'menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menu menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String name = json['name'];
    String description = json['description'];
    String pictureId = json['pictureId'];
    String city = json['city'];
    double rating = json['rating'];
    Menu menus = Menu.fromJson(json['menus']);

    return Restaurant(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      rating: rating,
      menus: menus,
    );
  }
}