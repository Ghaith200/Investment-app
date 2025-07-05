import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/features/home/models/get_offers_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferService {
  static Future<List<GetOfferModel>> getMyOffers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/my-offers'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((offer) => GetOfferModel.fromJson(offer))
          .toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }
}
