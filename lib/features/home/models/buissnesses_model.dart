import 'package:investement_app/core/models/user_model.dart';

import 'category_model.dart';

class BusinessModel {
  final int? id;
  final int? userId;
  final int? categoryId;
  final String businessName;
  final String description;
  final String? businessPhoto;
  final String valuation;
  final String moneyNeeded;
  final String percentageOffered;
  final String location;
  final int? employeesCount;
  final int? foundedYear;
  final String businessModel;
  final String targetMarket;
  final String competitiveAdvantages;
  final bool isActive;
  final CategoryModel category;
  final UserModel? user;

  BusinessModel({
    this.id,
    this.userId,
    this.categoryId,
    required this.businessName,
    required this.description,
    this.businessPhoto,
    required this.valuation,
    required this.moneyNeeded,
    required this.percentageOffered,
    required this.location,
    this.employeesCount,
    this.foundedYear,
    required this.businessModel,
    required this.targetMarket,
    required this.competitiveAdvantages,
    required this.isActive,
    this.user,
    required this.category,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      businessName: json['business_name'] ?? '',
      description: json['description'] ?? '',
      businessPhoto: json['business_photo'],
      valuation: json['valuation'] ?? '0',
      moneyNeeded: json['money_needed'] ?? '0',
      percentageOffered: json['percentage_offered'] ?? '0',
      location: json['location'] ?? '',
      employeesCount: json['employees_count'],
      foundedYear: json['founded_year'],
      businessModel: json['business_model'] ?? '',
      targetMarket: json['target_market'] ?? '',
      competitiveAdvantages: json['competitive_advantages'] ?? '',
      isActive: json['is_active'] ?? false,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : CategoryModel(
              id: 0,
              name: '',
              slug: '',
              description: '',
              createdAt: '',
              updatedAt: '',
              businessesCount: 0,
            ),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : UserModel(
              // Fallback for null user
              id: 0,
              country: 'Unkown',
              birthDate: '',
              bio: '',
              type: '',
              title: '',

              name: 'Unknown Owner',
              email: '',
            ),
    );
  }
}
