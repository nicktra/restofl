class RestaurantDetail {
  RestaurantDetail({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        pictureId: json["pictureId"] == null ? null : json["pictureId"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        customerReviews: json["customerReviews"] == null
            ? null
            : List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}

class Category {
  Category({
    this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"] == null ? null : json["name"],
      );
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"] == null ? null : json["name"],
        review: json["review"] == null ? null : json["review"],
        date: json["date"] == null ? null : json["date"],
      );
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? null
            : List<Category>.from(
                json["foods"].map((x) => Category.fromJson(x))),
        drinks: json["drinks"] == null
            ? null
            : List<Category>.from(
                json["drinks"].map((x) => Category.fromJson(x))),
      );
}
