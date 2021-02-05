import 'dart:async';

import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/model/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:restofl/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({@required this.apiService});

  RestaurantDetail _restaurantDetail;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantDetail get result => _restaurantDetail;
  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final _restaurant = await apiService.getRestaurantDetail(id);
      if (_restaurant.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = _restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
