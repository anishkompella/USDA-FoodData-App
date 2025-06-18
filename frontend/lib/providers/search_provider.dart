import 'package:flutter/foundation.dart';
import '../models/search_item.dart';
import '../services/api.dart';

class SearchProvider extends ChangeNotifier {
  final _api = Api();
  List<SearchItem> results = [];
  bool isLoading = false;
  String? error;

  Future<void> search(String query) async {
    isLoading = true; error = null; notifyListeners();
    try {
      results = await _api.searchFoods(query);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false; notifyListeners();
    }
  }
}