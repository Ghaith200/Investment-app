import 'package:dio/dio.dart';
import 'package:investement_app/features/home/models/category_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<CategoryResponse> getCategories() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8000/api/categories');
      return CategoryResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
