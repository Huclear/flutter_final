import 'measure.dart';

class Ingredient {
  String name;
  double amount;
  Measure measureType;

  Ingredient({
    required this.name,
    required this.amount,
    required this.measureType,
  });

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map["name"],
      amount: map["amount"] is int 
      ? (map["amount"] as int).toDouble()
      : (map["amount"] as double),
      measureType: Measure.values.firstWhere(
        (e) => e.name == map["measureType"] as String,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'amount': amount, 'measureType': measureType.name};
  }
}
