import 'package:cloud_firestore/cloud_firestore.dart';

class Recipies {
  String name;
  int grams, calories, fats, protines, carbon;
  DocumentReference reference;

  Recipies(this.calories, this.carbon, this.fats, this.grams, this.name,
      this.protines, this.reference);

  Recipies.fromMap(Map<String, dynamic> map, {required this.reference})
      : name = map['name'],
        grams = map['grams'],
        carbon = map['carbon'],
        protines = map['protiens'],
        fats = map['fats'],
        calories = map['calories'];

  // Recipies.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data, reference: snapshot.reference);
}
