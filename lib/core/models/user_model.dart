class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String country;
  final String? gender;
  final String birthDate;
  final String type;
  final String title;
  final String? profileImage;
  final String bio;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.country,
    this.gender,
    required this.birthDate,
    required this.type,
    required this.title,
    this.profileImage,
    required this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      country: json['country'],
      gender: json['gender'],
      birthDate: json['birth_date'],
      type: json['type'],
      title: json['title'],
      profileImage: json['profile_image'],
      bio: json['bio'],
    );
  }
}

class LoginResponseModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final UserModel user;

  LoginResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
