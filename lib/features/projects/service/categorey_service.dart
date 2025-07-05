import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/features/home/models/category_model.dart';

class CategoryService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
