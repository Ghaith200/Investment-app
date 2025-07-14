import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:investement_app/features/zoom_meetings/models/zoom_meeting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZoomMeetingService {
  final Dio _dio = Dio();

  Future<ZoomMeetingModel> createMeeting({
    required String topic,
    required String agenda,
    required String startTime,
    required int duration,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final response = await _dio.post('http://10.0.2.2:8000/api/zoom/meetings',
          data: {
            'topic': topic,
            'agenda': agenda,
            'start_time': startTime,
            'duration': duration,
          },
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        log('Meeting created successfully: ${response.data}');
        return ZoomMeetingModel.fromJson(response.data);
      } else {
        throw Exception('something went wrong failed to create meeting');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
