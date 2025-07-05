import 'package:investement_app/features/home/models/buissnesses_model.dart';

class WishlistModel {
  final int id;
  final int userId;
  final int businessId;
  final String createdAt;
  final String updatedAt;
  final BusinessModel business;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.createdAt,
    required this.updatedAt,
    required this.business,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      businessId: json['business_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      business: BusinessModel.fromJson(json['business'] ?? {}),
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? phone;
  final String country;
  final String? gender;
  final String birthDate;
  final String type;
  final String title;
  final String profileImage;
  final String bio;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.phone,
    required this.country,
    this.gender,
    required this.birthDate,
    required this.type,
    required this.title,
    required this.profileImage,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      phone: json['phone'],
      country: json['country'] ?? '',
      gender: json['gender'],
      birthDate: json['birth_date'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      profileImage: json['profile_image'] ?? '',
      bio: json['bio'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
