import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restofl/data/api/api_service.dart';
import 'package:restofl/data/model/restaurant_list.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('api service test', () {
    test('returns a Restaurant List if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(ApiService.baseUrl + ApiService.list))
          .thenAnswer((_) async {
        var result = await rootBundle.loadString('assets/restaurant_list.json');

        return http.Response(result, 200);
      });

      expect(await ApiService().fetchRestaurantList(client),
          isA<RestaurantList>());
    });
  });
}
