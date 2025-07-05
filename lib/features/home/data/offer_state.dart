import 'package:investement_app/features/home/models/offer_model.dart';

abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferCreating extends OfferState {}

class OfferCreated extends OfferState {
  final OfferModel offer;
  OfferCreated(this.offer);
}

class OfferError extends OfferState {
  final String message;
  OfferError(this.message);
}