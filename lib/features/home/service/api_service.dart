import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import '../models/category_model.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<BusinessModel>> getBusinesses(
      {int? categoryId, String? searchQuery}) async {
    final Map<String, String> queryParams = {};
    if (categoryId != null) queryParams['category_id'] = categoryId.toString();
    if (searchQuery != null && searchQuery.isNotEmpty)
      queryParams['search'] = searchQuery;

    final uri =
        Uri.parse('$baseUrl/businesses').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['data'];
      return data.map((e) => BusinessModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load businesses');
    }
  }
}
