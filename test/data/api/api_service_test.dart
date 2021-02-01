import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restofl/data/api/api_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('api service test', () {
    test('Get Restaurant by Id', () async {
      final client = MockClient();
      String id = "rqdv5juczeskfw1e867";
      when(client.get(ApiService.baseUrl + ApiService.detail + id))
          .thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/restaurant_detail.json');

        return http.Response(jsonEncode(result), 200);
      });
      final response = await ApiService().getRestaurantDetail(id);
      var restaurant = response.restaurant;
      expect(restaurant.name, "Melting Pot");
    });
  });
}
