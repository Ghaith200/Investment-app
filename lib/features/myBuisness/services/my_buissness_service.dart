import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessService {
  static const String baseUrl =
      "http://10.0.2.2:8000/api"; // emulator localhost

  static Future<List<BusinessModel>> getMyBusinesses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/my-businesses'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => BusinessModel.fromJson(e)).toList();
      } else {
        print('❌ Error: ${response.statusCode}');
        print('❗ Response Body: ${response.body}');
        throw Exception('Failed to load businesses');
      }
    } catch (e) {
      print('🔥 Exception occurred: $e');
      rethrow;
    }
  }
}
