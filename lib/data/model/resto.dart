import 'dart:convert';
import 'package:restofl/data/model/menus.dart';

class Resto {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Resto({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  Resto.fromJson(Map<String, dynamic> resto) {
    id = resto['id'];
    name = resto['name'];
    description = resto['description'];
    pictureId = resto['pictureId'];
    city = resto['city'];
    rating = resto['rating'].toDouble();
    menus = resto['menus'] != null ? new Menus.fromJson(resto['menus']) : null;
  }
}

List<Resto> parseResto(String json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Resto.fromJson(json)).toList();
}
