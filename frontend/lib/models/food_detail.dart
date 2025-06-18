class FoodDetail {
  final int fdcId;
  final String description;
  final String dataType;
  final List<FoodNutrient> foodNutrients;

  FoodDetail({
    required this.fdcId,
    required this.description,
    required this.dataType,
    required this.foodNutrients,
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    final List<dynamic> raw = json['foodNutrients'] as List<dynamic>? ?? [];
    final nutrients = raw.map((e) => FoodNutrient.fromJson(e as Map<String, dynamic>))
.toList();

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
  final double amount;
  final String unit;

  FoodNutrient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });

  factory FoodNutrient.fromJson(Map<String, dynamic> j) {
    final nut = j['nutrient'] as Map<String, dynamic>? ?? {};
    return FoodNutrient(
      id: j['id'] as int? ?? 0,
      name: nut['name'] as String? ?? '',
      amount: j['amount'] is num? (j['amount'] as num).toDouble(): 0.0,
      unit: nut['unitName'] as String? ?? '',
    );
  }
}
