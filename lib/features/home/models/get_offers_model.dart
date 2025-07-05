import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';

class GetOfferModel {
  final int id;
  final int businessId;
  final int investorId;
  final double offeredAmount;
  final double requestedPercentage;
  final String message;
  final String status;
  final int? parentOfferId;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BusinessModel business;

  GetOfferModel({
    required this.id,
    required this.businessId,
    required this.investorId,
    required this.offeredAmount,
    required this.requestedPercentage,
    required this.message,
    required this.status,
    this.parentOfferId,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    required this.business,
  });

  factory GetOfferModel.fromJson(Map<String, dynamic> json) {
    return GetOfferModel(
      id: json['id'],
      businessId: json['business_id'],
      investorId: json['investor_id'],
      offeredAmount: double.parse(json['offered_amount'].toString()),
      requestedPercentage:
          double.parse(json['requested_percentage'].toString()),
      message: json['message'],
      status: json['status'],
      parentOfferId: json['parent_offer_id'],
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      business: BusinessModel.fromJson(json['business']),
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
      case 'pending':
      default:
        return Colors.orange;
    }
  }
}
