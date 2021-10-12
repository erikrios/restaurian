import 'package:flutter/material.dart';
import 'package:restaurian/data/api/api_service.dart';
import 'package:restaurian/data/model/restaurant_detail_response.dart';
import 'package:restaurian/provider/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  ResultState<RestaurantDetailResponse> _state =
      ResultState(status: Status.loading, message: null, data: null);

  ResultState<RestaurantDetailResponse> get state => _state;

  Future<ResultState> getRestaurant(String id) async {
    try {
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestaurantDetailResponse restaurantDetailResponse =
          await apiService.getRestaurant(id);
      _state = ResultState(
          status: Status.hasData,
          message: null,
          data: restaurantDetailResponse);
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
