class FoodDetail {
  final int fdcId;
  final String description;
  final String dataType;
  final List<FoodNutrient> foodNutrients;

  FoodDetail({
    required this.fdcId,
    required this.description, //food name
    required this.dataType,
    required this.foodNutrients, // full list of all available nutrient data
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    final List<dynamic> raw = json['foodNutrients'] as List<dynamic>? ?? [];
    final nutrients = raw.map((e) => FoodNutrient.fromJson(e as Map<String, dynamic>)).toList(); // Converts each element of the list to a FoodNutrient instance

    return FoodDetail(
      fdcId: json['fdcId'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      dataType: json['dataType'] as String? ?? '',
      foodNutrients: nutrients,
    );
  }
}


class FoodNutrient {
  final int id;
  final String name;
  final double amount; //per 100g 
  final String unit;

  FoodNutrient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });

  factory FoodNutrient.fromJson(Map<String, dynamic> j) {
    final nut = j['nutrient'] as Map<String, dynamic>? ?? {}; //converts each nutrient object to a map
    return FoodNutrient(
      id: j['id'] as int? ?? 0,
      name: nut['name'] as String? ?? 'Not Available',
      amount: j['amount'] is num? (j['amount'] as num).toDouble(): 0.0,
      unit: nut['unitName'] as String? ?? '',
    );
  }
}
