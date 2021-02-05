import 'dart:async';

import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/model/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:restofl/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}) {
    _fetchAllRestaurant();
  }

  RestaurantList _restaurantList;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantList get result => _restaurantList;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final _restaurant = await apiService.getRestaurantList();
      if (_restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = _restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
