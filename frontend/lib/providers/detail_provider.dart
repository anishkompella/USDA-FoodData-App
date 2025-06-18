import 'package:flutter/foundation.dart';
import '../models/food_detail.dart';
import '../services/api.dart';

class DetailProvider extends ChangeNotifier {
  final _api = Api();
  FoodDetail? detail;
  bool isLoading = false;
  String? error;

  Future<void> fetch(int fdcId) async {
    isLoading = true; error = null; notifyListeners();
    try {
      detail = await _api.fetchFoodDetail(fdcId);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false; notifyListeners();
    }
  }
}