import 'package:flutter/material.dart';
import 'package:restaurian/data/api/api_service.dart';
import 'package:restaurian/data/model/restaurant_list_response.dart';
import 'package:restaurian/provider/result_state.dart';

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
    } catch (e) {
      _state =
          ResultState(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}
