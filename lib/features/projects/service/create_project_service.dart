import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:investement_app/features/home/models/buissnesses_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';

  // Post business data to the server
  static Future<BusinessModel> createBusiness(BusinessModel business) async {
    try {
      final uri = Uri.parse('$baseUrl/businesses');
      var request = http.MultipartRequest('POST', uri);

      // Add fields
      request.fields['category_id'] = business.categoryId?.toString() ?? '';
      request.fields['business_name'] = business.businessName;
      request.fields['description'] = business.description;
      request.fields['valuation'] = business.valuation;
      request.fields['money_needed'] = business.moneyNeeded;
      request.fields['percentage_offered'] = business.percentageOffered;
      request.fields['location'] = business.location;
      request.fields['employees_count'] =
          business.employeesCount?.toString() ?? '';
      request.fields['founded_year'] = business.foundedYear?.toString() ?? '';
      request.fields['business_model'] = business.businessModel;
      request.fields['target_market'] = business.targetMarket;
      request.fields['competitive_advantages'] = business.competitiveAdvantages;

      // Add file if exists
      if (business.businessPhoto != null &&
          business.businessPhoto!.isNotEmpty) {
        var file = await http.MultipartFile.fromPath(
            'business_photo', business.businessPhoto!);
        request.files.add(file);
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        return BusinessModel.fromJson(json.decode(respStr));
      } else {
        throw Exception('Failed to create business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create business: $e');
    }
  }

  // Get all businesses
  static Future<List<BusinessModel>> getBusinesses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/businesses'));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body
            .map((dynamic item) => BusinessModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load businesses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load businesses: $e');
    }
  }

  // Get single business by ID
  static Future<BusinessModel> getBusiness(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/businesses/$id'));

      if (response.statusCode == 200) {
        return BusinessModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load business: $e');
    }
  }

  // Update business
  static Future<BusinessModel> updateBusiness(BusinessModel business) async {
    try {
      final uri = Uri.parse('$baseUrl/businesses/${business.id}');
      var request = http.MultipartRequest('PUT', uri);

      // Add fields
      request.fields['category_id'] = business.categoryId?.toString() ?? '';
      request.fields['business_name'] = business.businessName;
      request.fields['description'] = business.description;
      request.fields['valuation'] = business.valuation;
      request.fields['money_needed'] = business.moneyNeeded;
      request.fields['percentage_offered'] = business.percentageOffered;
      request.fields['location'] = business.location;
      request.fields['employees_count'] =
          business.employeesCount?.toString() ?? '';
      request.fields['founded_year'] = business.foundedYear?.toString() ?? '';
      request.fields['business_model'] = business.businessModel;
      request.fields['target_market'] = business.targetMarket;
      request.fields['competitive_advantages'] = business.competitiveAdvantages;
      request.fields['is_active'] = business.isActive.toString();

      // Add file if exists
      if (business.businessPhoto != null &&
          business.businessPhoto!.isNotEmpty) {
        var file = await http.MultipartFile.fromPath(
            'business_photo', business.businessPhoto!);
        request.files.add(file);
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return BusinessModel.fromJson(json.decode(respStr));
      } else {
        throw Exception('Failed to update business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update business: $e');
    }
  }

  // Delete business
  static Future<bool> deleteBusiness(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/businesses/$id'));

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete business: $e');
    }
  }
}
