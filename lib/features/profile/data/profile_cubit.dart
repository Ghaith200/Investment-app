import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      // 🔐 Load token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        emit(ProfileFailure("Token not found"));
        return;
      }

      final dio = Dio();

      // 📡 Send request with Authorization header
      final response = await dio.get(
        'http://10.0.2.2:8000/api/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final model = ProfileModel.fromJson(data);
        emit(ProfileSuccess(model));
      } else {
        emit(ProfileFailure("Failed to load profile"));
      }
    } catch (e) {
      emit(ProfileFailure('Failed to load profile: $e'));
    }
  }
}
