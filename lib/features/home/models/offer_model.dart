class OfferModel {
  final int id;
  final int businessId;
  final double offeredAmount;
  final double requestedPercentage;
  final String message;
  final int? parentOfferId;
  final int investorId;
  final DateTime createdAt;
  final DateTime updatedAt;

  OfferModel({
    required this.id,
    required this.businessId,
    required this.offeredAmount,
    required this.requestedPercentage,
    required this.message,
    this.parentOfferId,
    required this.investorId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      businessId: json['business_id'],
      offeredAmount: double.parse(json['offered_amount'].toString()),
      requestedPercentage: double.parse(json['requested_percentage'].toString()),
      message: json['message'],
      parentOfferId: json['parent_offer_id'],
      investorId: json['investor_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_id': businessId,
      'offered_amount': offeredAmount,
      'requested_percentage': requestedPercentage,
      'message': message,
      'parent_offer_id': parentOfferId,
    };
  }
}