import 'package:flutter/material.dart';
import 'package:restaurian/data/db/database_helper.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState<List<Restaurant>> _restaurantsState =
      ResultState(status: Status.hasData, message: null, data: []);

  ResultState<List<Restaurant>> get restaurantsState => _restaurantsState;

  bool _isSuccessfullyInserted = false;

  bool get isSuccessfullyInserted => _isSuccessfullyInserted;

  bool _isSuccessfullyDeleted = false;

  bool get isSuccessfullyDeleted => _isSuccessfullyDeleted;

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void _getFavorites() async {
    _restaurantsState =
        ResultState(status: Status.loading, message: null, data: null);
    notifyListeners();

    try {
      List<Restaurant> restaurants = await databaseHelper.getRestaurants();
      _restaurantsState =
          ResultState(status: Status.hasData, message: null, data: restaurants);
      notifyListeners();
    } catch (e) {
      _restaurantsState =
          ResultState(status: Status.error, message: 'Error: $e', data: null);
      notifyListeners();
    }
  }

  void addFavorite(Restaurant restaurant) async {
    _isSuccessfullyInserted = false;
    try {
      int affectedRows = await databaseHelper.insertRestaurant(restaurant);
      if (affectedRows > 0) {
        _isSuccessfullyInserted = true;
        _getFavorites();
      } else {
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
    }
  }

  void isFavoriteExists(String id) async {
    _isFavorite = await databaseHelper.isFavorite(id);
    notifyListeners();
  }

  void removeFavorite(String id) async {
    _isSuccessfullyDeleted = false;
    try {
      int affectedRows = await databaseHelper.removeRestaurant(id);
      if (affectedRows > 0) {
        _isSuccessfullyDeleted = true;
        _getFavorites();
      } else {
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
    }
  }
}
