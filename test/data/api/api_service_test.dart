import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/model/restaurant_detail.dart';

class MockClient extends Mock implements ApiService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('api service test', () {
    MockClient api;

    setUp(() {
      api = MockClient();
    });

    test('Get Restaurant by Id', () async {
      String id = "rqdv5juczeskfw1e867";
      when(api.getRestaurantDetail(id)).thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/restaurant_detail.json');

        return RestaurantDetail.fromJson(json.decode(result));
      });
      final response = await api.getRestaurantDetail(id);
      var restaurant = response.restaurant;
      expect(restaurant.name, "Melting Pot");
    });
  });
}
