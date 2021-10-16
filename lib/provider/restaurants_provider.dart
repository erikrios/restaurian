import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurian/data/api/api_service.dart';
import 'package:restaurian/data/model/restaurant_list_response.dart';
import 'package:restaurian/utils/result_state.dart';
import 'package:restaurian/utils/constant.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    _getRestaurants();
  }

  ResultState<RestaurantListResponse> _state =
      ResultState(status: Status.loading, message: null, data: null);

  ResultState<RestaurantListResponse> get state => _state;

  Future<ResultState> _getRestaurants() async {
    try {
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestaurantListResponse restaurantListResponse =
          await apiService.getRestaurants();
      _state = ResultState(
          status: Status.hasData, message: null, data: restaurantListResponse);
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
