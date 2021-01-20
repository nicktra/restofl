import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restofl/data/model/restaurant_list.dart';
import 'package:restofl/data/model/restaurant_detail.dart';
import 'package:restofl/data/model/restaurant_search.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static final String _list = 'list';
  static final String _detail = 'detail/';
  static final String _search = 'search?q=';

  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(_baseUrl + _list);
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(_baseUrl + _detail + id);
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(String text) async {
    final response = await http.get(_baseUrl + _search + text);
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restauarant Search');
    }
  }
}
