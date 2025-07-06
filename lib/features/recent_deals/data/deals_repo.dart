import 'package:dio/dio.dart';
import 'package:investement_app/features/recent_deals/models/recent_offers_model.dart';

class DealsRepository {
  final Dio dio;

  DealsRepository(this.dio);

  Future<List<Deal>> fetchRecentDeals() async {
    try {
      final response = await dio.get('http://10.0.2.2:8000/api/deals/recent');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Deal.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load deals: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}