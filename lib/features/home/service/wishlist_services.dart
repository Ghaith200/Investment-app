import 'dart:convert';
import 'package:http/http.dart' as http;

class WishlistService {
  static Future<bool> addToWishlist(int businessId) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/wishlist");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer YOUR_TOKEN_HERE',
        },
        body: jsonEncode({'business_id': businessId}),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
