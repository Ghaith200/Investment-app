import 'package:investement_app/features/home/models/get_offers_model.dart';

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersLoaded extends OffersState {
  final List<GetOfferModel> offers;
  OffersLoaded(this.offers);
}

class OffersError extends OffersState {
  final String message;
  OffersError(this.message);
}