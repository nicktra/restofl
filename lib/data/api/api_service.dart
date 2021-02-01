import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restofl/data/model/restaurant_list.dart';
import 'package:restofl/data/model/restaurant_detail.dart';
import 'package:restofl/data/model/restaurant_search.dart';

class ApiService {
  static final String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static final String list = 'list';
  static final String detail = 'detail/';
  static final String _search = 'search?q=';

  Future<RestaurantList> fetchRestaurantList(http.Client client) async {
    final response = await client.get(baseUrl + list);

    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<RestaurantList> getRestaurantList() async {
    final _response = await http.get(baseUrl + list);
    if (_response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(_response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final _response = await http.get(baseUrl + detail + id);
    if (_response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(_response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(String text) async {
    final _response = await http.get(baseUrl + _search + text);
    if (_response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(_response.body));
    } else {
      throw Exception('Failed to load Restauarant Search');
    }
  }
}
