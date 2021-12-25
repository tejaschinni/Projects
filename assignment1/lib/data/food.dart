// To parse this JSON data, do
//
//     final Food = FoodFromJson(jsonString);

import 'dart:convert';

List<Food> FoodFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String FoodToJson(List<Food> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
  Food({
    required this.name,
    required this.gram,
    required this.calories,
    required this.fats,
    required this.protein,
    required this.carbon,
    required this.fiber,
  });

  String name;
  String gram;
  String calories;
  String fats;
  String protein;
  String carbon;
  String fiber;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
        gram: json["gram"],
        calories: json["calories"],
        fats: json["fats"],
        protein: json["protein"],
        carbon: json["carbon"],
        fiber: json["fiber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gram": gram,
        "calories": calories,
        "fats": fats,
        "protein": protein,
        "carbon": carbon,
        "fiber": fiber,
      };
}
