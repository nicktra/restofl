class Menus {
  List<String> foods;
  List<String> drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = new List<String>();
      json['foods'].forEach((v) {
        foods.add(v['name']);
      });
    }
    if (json['drinks'] != null) {
      drinks = new List<String>();
      json['drinks'].forEach((v) {
        drinks.add(v['name']);
      });
    }
  }
}
