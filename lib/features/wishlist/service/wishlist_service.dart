import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/features/wishlist/model/wishlist_model.dart';

class WishlistService {
  final String baseUrl = 'http://10.0.2.2:8000/api';
  final String? authToken;

  WishlistService({required this.authToken});

  Future<List<WishlistModel>> getWishlist() async {
    try {
      print('Attempting to fetch wishlist...');

      final response = await http.get(
        Uri.parse('$baseUrl/wishlist'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Successfully fetched ${data.length} wishlist items');
        return data.map((json) => WishlistModel.fromJson(json)).toList();
      } else {
        final errorResponse = json.decode(response.body);
        final errorMessage =
            errorResponse['message'] ?? 'Failed to load wishlist';
        print('Error fetching wishlist: $errorMessage');
        throw Exception(errorMessage);
      }
    } on http.ClientException catch (e) {
      print('Network error occurred: $e');
      throw Exception('Network error: Please check your internet connection');
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw Exception('Data format error: Invalid server response');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}
