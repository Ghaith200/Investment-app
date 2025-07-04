import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception("Token not found");

    final response = await Dio().post(
      'http://10.0.2.2:8000/api/logout',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    if (response.statusCode == 200) {
      await prefs.clear(); // clear all if needed
    } else {
      throw Exception("Logout failed");
    }
  }
}
