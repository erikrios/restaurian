import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurian/data/model/restaurant_detail_response.dart';
import 'package:restaurian/data/model/restaurant_list_response.dart';
import 'package:restaurian/data/model/restaurant_search_response.dart';

class ApiService {
  static const String _baseUrl = 'restaurant-api.dicoding.dev';
  static const String _listEndpoint = '/list';
  static const String _detailEndpoint = '/detail';
  static const String _searchEndpoint = '/search';
  static const int _timeout = 5;

  Future<RestaurantListResponse> getRestaurants() async {
    final Uri uri = Uri.https(_baseUrl, _listEndpoint);

    try {
      final response = await http.get(uri).timeout(
            const Duration(seconds: _timeout),
          );
      if (response.statusCode == HttpStatus.ok) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load the restaurant list.');
      }
    } on Error {
      rethrow;
    }
  }

  Future<RestaurantDetailResponse> getRestaurant(String id) async {
    final Uri uri = Uri.https(_baseUrl, '$_detailEndpoint/$id');

    try {
      final response = await http.get(uri).timeout(
            const Duration(seconds: _timeout),
          );
      if (response.statusCode == HttpStatus.ok) {
        return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == HttpStatus.notFound) {
        throw Exception('Restaurant with given ID not found.');
      } else {
        throw Exception('Failed to load the restaurant details.');
      }
    } on Error {
      rethrow;
    }
  }

  Future<RestaurantSearchResponse> searchRestaurants(String keyword) async {
    final Uri uri = Uri.https(
      _baseUrl,
      _searchEndpoint,
      {
        "q": keyword,
      },
    );

    try {
      final response =
          await http.get(uri).timeout(const Duration(seconds: _timeout));

      if (response.statusCode == HttpStatus.ok) {
        return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load the restaurants search result.');
      }
    } on Error {
      rethrow;
    }
  }
}
