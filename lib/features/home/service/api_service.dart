import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/core/models/user_model.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<UserModel> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return UserModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
