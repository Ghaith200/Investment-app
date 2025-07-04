import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/core/models/user_model.dart';
import 'package:investement_app/features/Auth/sign_in/data/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final Dio _dio = Dio();

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8000/api/login',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "email": email,
          "password": password,
        },
      );

      final loginModel = LoginResponseModel.fromJson(response.data);

      // Save token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", loginModel.accessToken);

      emit(LoginSuccess(loginModel));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
