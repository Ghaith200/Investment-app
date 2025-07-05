import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:investement_app/core/models/offer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferService {
  static Future<List<OfferModel>> getBusinessOffers(int businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/businesses/$businessId/offers'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((offer) => OfferModel.fromJson(offer)).toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }

  static Future<void> acceptOffer(int offerId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/offers/$offerId/accept'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to accept offer');
    }
  }

  static Future<void> rejectOffer(int offerId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/offers/$offerId/reject'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reject offer');
    }
  }

  static Future<void> counterOffer(
    int offerId, {
    required double offeredAmount,
    required double requestedPercentage,
    required String message,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/offers/$offerId/counter'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'offered_amount': offeredAmount,
        'requested_percentage': requestedPercentage,
        'message': message,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create counter offer');
    }
  }
}
