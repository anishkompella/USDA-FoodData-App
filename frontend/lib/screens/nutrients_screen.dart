import 'package:flutter/material.dart';
import '../models/food_detail.dart';
import '../services/api.dart';

class NutrientsScreen extends StatelessWidget {
  final int fdcId;
  final String title;

  const NutrientsScreen({
    required this.fdcId,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutrients')),
      body: FutureBuilder<FoodDetail>(
        future: Api().fetchFoodDetail(fdcId),
        builder: (c, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }

          final detail = snap.data!;
          final nutrients = detail.foodNutrients;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(ctx).textTheme.titleLarge),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nutrient')),
                        DataColumn(label: Text('Amount')),
                      ],
                      rows: nutrients.map((fn) {
                        return DataRow(cells: [
                          DataCell(Text(fn.name)),
                          DataCell(Text('${fn.amount} ${fn.unit}')),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
