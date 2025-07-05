import 'package:investement_app/core/models/offer_model.dart';

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersLoaded extends OffersState {
  final List<OfferModel> offers;
  OffersLoaded(this.offers);
}

class OffersError extends OffersState {
  final String message;
  OffersError(this.message);
}

class OfferAccepted extends OffersState {}

class OfferRejected extends OffersState {}

class CounterOfferCreated extends OffersState {}