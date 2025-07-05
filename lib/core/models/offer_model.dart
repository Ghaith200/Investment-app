import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investement_app/core/models/user_model.dart';

class OfferModel {
  final int id;
  final int businessId;
  final int investorId;
  final double offeredAmount;
  final double requestedPercentage;
  final String message;
  final String status;
  final int? parentOfferId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel investor;

  OfferModel({
    required this.id,
    required this.businessId,
    required this.investorId,
    required this.offeredAmount,
    required this.requestedPercentage,
    required this.message,
    required this.status,
    this.parentOfferId,
    required this.createdAt,
    required this.updatedAt,
    required this.investor,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      businessId: json['business_id'],
      investorId: json['investor_id'],
      offeredAmount: double.parse(json['offered_amount'].toString()),
      requestedPercentage: double.parse(json['requested_percentage'].toString()),
      message: json['message'],
      status: json['status'],
      parentOfferId: json['parent_offer_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      investor: UserModel.fromJson(json['investor']),
    );
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(createdAt);
  }

  String get formattedAmount {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 0)
        .format(offeredAmount);
  }

  String get formattedPercentage {
    return '${requestedPercentage.toStringAsFixed(1)}%';
  }

  Color get statusColor {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'countered':
        return Colors.orange;
      case 'pending':
      default:
        return Colors.blueAccent;
    }
  }
}