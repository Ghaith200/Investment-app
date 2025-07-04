import 'dart:io';

class RegisterModel {
  final String name;
  final String email;
  final String password;
  final File profileImage;
  final String country;
  final String birthdate;
  final String type;
  final String title;
  final String bio;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.profileImage,
    required this.country,
    required this.birthdate,
    required this.type,
    required this.title,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'country': country,
        'birth_date': birthdate,
        'type': type,
        'title': title,
        'bio': bio,
      };
}
