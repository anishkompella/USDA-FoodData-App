import 'package:flutter/foundation.dart';
import '../models/search_item.dart';
import '../services/api.dart';

class SearchProvider extends ChangeNotifier {
  final _api = Api(); //instance of api service
  List<SearchItem> results = []; //Objects returned from the last search
  bool isLoading = false; //true when search is in progress
  String? error;

  Future<void> search(String query) async {
    isLoading = true; error = null; notifyListeners(); //UI will rebuild if called 
    try {
      results = await _api.searchFoods(query);  //fetches and parses data into a list of Search Items
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false; notifyListeners();
    }
  }
}

