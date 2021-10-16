import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurian/data/api/api_service.dart';
import 'package:restaurian/data/model/restaurant_search_response.dart';
import 'package:restaurian/utils/result_state.dart';
import 'package:restaurian/utils/constant.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  ResultState<RestaurantSearchResponse> _state = ResultState(
    status: Status.hasData,
    message: null,
    data: RestaurantSearchResponse(
      error: false,
      founded: 0,
      restaurants: [],
    ),
  );

  ResultState<RestaurantSearchResponse> get state => _state;

  Future<ResultState> searchRestaurant(String keyword) async {
    try {
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestaurantSearchResponse restaurantSearchResponse =
          await apiService.searchRestaurants(keyword);
      _state = ResultState(
          status: Status.hasData,
          message: null,
          data: restaurantSearchResponse);
      notifyListeners();
      return _state;
    } on TimeoutException {
      _state = ResultState(
          status: Status.error, message: timeoutExceptionMessage, data: null);
      notifyListeners();
      return _state;
    } on SocketException {
      _state = ResultState(
          status: Status.error, message: socketExceptionMessage, data: null);
      notifyListeners();
      return _state;
    } on Error catch (e) {
      _state =
          ResultState(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}
