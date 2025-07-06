class Deal {
  final int id;
  final int businessId;
  final int investorId;
  final int acceptedOfferId;
  final double finalAmount;
  final double finalPercentage;
  final DateTime dealDate;
  final String status;
  final Business business;
  final Investor investor;

  Deal({
    required this.id,
    required this.businessId,
    required this.investorId,
    required this.acceptedOfferId,
    required this.finalAmount,
    required this.finalPercentage,
    required this.dealDate,
    required this.status,
    required this.business,
    required this.investor,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      businessId: json['business_id'],
      investorId: json['investor_id'],
      acceptedOfferId: json['accepted_offer_id'],
      finalAmount: double.parse(json['final_amount'].toString()),
      finalPercentage: double.parse(json['final_percentage'].toString()),
      dealDate: DateTime.parse(json['deal_date']),
      status: json['status'],
      business: Business.fromJson(json['business']),
      investor: Investor.fromJson(json['investor']),
    );
  }
}

class Business {
  final int id;
  final int userId;
  final int categoryId;
  final String businessName;
  final String description;
  final String businessPhoto;
  final double valuation;
  final User user;
  final Category category;

  Business({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.businessName,
    required this.description,
    required this.businessPhoto,
    required this.valuation,
    required this.user,
    required this.category,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      businessName: json['business_name'],
      description: json['description'],
      businessPhoto: json['business_photo'],
      valuation: double.parse(json['valuation'].toString()),
      user: User.fromJson(json['user']),
      category: Category.fromJson(json['category']),
    );
  }
}

class Investor {
  final int id;
  final String name;
  final String email;
  final String? profileImage;

  Investor({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
  });

  factory Investor.fromJson(Map<String, dynamic> json) {
    return Investor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profile_image'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profileImage: json['profile_image'],
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}