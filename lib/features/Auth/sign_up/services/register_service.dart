import 'package:dio/dio.dart';
import 'package:investement_app/features/Auth/sign_up/models/register_model.dart';

class RegisterService {
  final Dio dio;

  RegisterService(this.dio);

  Future<void> registerUser(RegisterModel model) async {
    final formData = FormData.fromMap({
      "name": model.name,
      "email": model.email,
      "password": model.password,
      "country": model.country,
      "birthdate": model.birthdate,
      "type": model.type,
      "title": model.title,
      "bio": model.bio,
      "profile_image": await MultipartFile.fromFile(
        model.profileImage.path,
        filename: model.profileImage.path.split('/').last,
      ),
    });

    final response =
        await dio.post('http://10.0.2.2:8000/api/register', data: formData);

    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to register: ${response.data}");
    }
  }
}
