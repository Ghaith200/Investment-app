import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/features/home/models/offer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferService {
  static Future<OfferModel> createOffer(OfferModel offer) async {
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString('token');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/offers'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'business_id': offer.businessId.toString(),
      },
      body: jsonEncode(offer.toJson()),
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return OfferModel.fromJson(jsonResponse['offer']);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to create offer');
    }
  }
}
