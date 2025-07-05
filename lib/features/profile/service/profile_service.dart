import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileService {
  static Future<ProfileModel?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return null;

      final response = await Dio().get(
        'http://10.0.2.2:8000/api/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['user'] ?? response.data;
        final profile = ProfileModel.fromJson(data);

        print("✅ Logged in user:");
        print("ID: ${profile.id}");
        print("Name: ${profile.name}");
        print("Email: ${profile.email}");
        print("Image: ${profile.profileImage}");

        return profile;
      }
    } catch (e) {
      print("❌ Error loading profile: $e");
    }

    return null;
  }
}
