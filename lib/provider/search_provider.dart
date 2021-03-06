import 'dart:async';

import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/model/restaurant_search.dart';
import 'package:flutter/material.dart';
import 'package:restofl/utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({@required this.apiService});

  RestaurantSearch _restaurantSearch;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantSearch get result => _restaurantSearch;
  ResultState get state => _state;

  Future<dynamic> fetchSearchRestaurant(String keyword) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final _restaurant = await apiService.getRestaurantSearch(keyword);
      if (_restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantSearch = _restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
