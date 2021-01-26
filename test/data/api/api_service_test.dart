import 'package:flutter_test/flutter_test.dart';
import 'package:restofl/data/api/api_service.dart';

void main() {
  group('api service test', () {
    ApiService apiService;
    setUp(() {
      apiService = ApiService();
    });
    test('Get Restaurant List and Check index 0', () async {
      // act
      var restaurantList = await apiService.getRestaurantList();
      // assert
      var result = restaurantList.restaurants[0];
      var restaurantName = result.name;
      expect(restaurantName, "Melting Pot");
    });
    test('Get Restaurant Detail By Id', () async {
      // act
      var restaurantDetail =
          await apiService.getRestaurantDetail('s1knt6za9kkfw1e867');
      // assert
      var result = restaurantDetail.error;
      expect(result, false);
    });
    test('Get Restaurant Search By Keyword Jeruk', () async {
      // act
      var restaurantSearch = await apiService.getRestaurantSearch('jeruk');
      // assert
      var result = restaurantSearch.error;
      expect(result, false);
    });
  });
}
