class Food {
  final String gram;
  final String calories;
  final String fats;
  final String protein;
  //final String fiber;
  final String carbon;
  final String name;

  Food({
    required this.gram,
    required this.calories,
    required this.fats,
    required this.protein,
    // required this.fiber,
    required this.carbon,
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      gram: json['gram'] as String,
      calories: json['calories'] as String,
      fats: json['fats'] as String,
      protein: json['protein'] as String,
      carbon: json['carbon'] as String,
      name: json['name'] as String,
      //fiber: json['fibre'] as String,
    );
  }
}
