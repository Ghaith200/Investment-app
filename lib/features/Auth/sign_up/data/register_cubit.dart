import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:investement_app/features/Auth/sign_up/models/register_model.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(RegisterModel model) async {
    emit(RegisterLoading());
    try {
      final formData = FormData.fromMap({
        ...model.toJson(),
        'profile_image': await MultipartFile.fromFile(model.profileImage.path,
            filename: model.profileImage.path.split('/').last),
      });

      final response = await Dio().post(
        'http://10.0.2.2:8000/api/register',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RegisterSuccess(response.data['token']));
      } else {
        final error = response.data['message'] ?? 'Failed to register';
        emit(RegisterFailure(error.toString()));
      }
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          final errors = <String>[];

          data.forEach((key, value) {
            if (value is List) {
              errors.addAll(value.map((e) => e.toString()));
            } else {
              errors.add(value.toString());
            }
          });

          final errorMessage = errors.join('\n');
          emit(RegisterFailure(errorMessage));
        } else {
          emit(RegisterFailure('Registration failed.'));
        }
      } else {
        emit(RegisterFailure(e.toString()));
      }
    }
  }
}
