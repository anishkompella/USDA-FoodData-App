import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/search_item.dart';
import '../models/food_detail.dart';

String get apiBaseUrl {
  return 'http://localhost:8000'; //gets the FastAPI server's root URL(can be changed to remote server later)
}

class Api {
  Future<List<SearchItem>> searchFoods(String query) async {
    final uri = Uri.parse('$apiBaseUrl/foods/search').replace( //builds api call
      queryParameters: {'query': query, 'pageSize': '20'},
    );
    final res = await http.get(uri); //http client waits for network call
    if (res.statusCode != 200) throw Exception(res.body);  //returns exception with raw data body if a successful response is not returned
    final data = json.decode(res.body)['foods'] as List;
    return data.map((j) => SearchItem.fromJson(j)).toList();
  }

  Future<FoodDetail> fetchFoodDetail(int fdcId) async {
    final uri = Uri.parse('$apiBaseUrl/food/$fdcId');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception(res.body);
    return FoodDetail.fromJson(json.decode(res.body)); //decodes JSON data and hands into to model cunstructor convert to FoodDetail class
  }
}