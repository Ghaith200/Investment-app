import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/myBuisness/data/create_offers_state.dart';
import 'package:investement_app/features/myBuisness/services/offer_service.dart';


class OffersCubit extends Cubit<OffersState> {
  final int businessId;
  
  OffersCubit({required this.businessId}) : super(OffersInitial()) {
    loadOffers();
  }

  Future<void> loadOffers() async {
    emit(OffersLoading());
    try {
      final offers = await OfferService.getBusinessOffers(businessId);
      emit(OffersLoaded(offers));
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  Future<void> acceptOffer(int offerId) async {
    try {
      emit(OffersLoading());
      await OfferService.acceptOffer(offerId);
      emit(OfferAccepted());
      loadOffers();
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  Future<void> rejectOffer(int offerId) async {
    try {
      emit(OffersLoading());
      await OfferService.rejectOffer(offerId);
      emit(OfferRejected());
      loadOffers();
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  Future<void> counterOffer(
    int offerId, {
    required double offeredAmount,
    required double requestedPercentage,
    required String message,
  }) async {
    try {
      emit(OffersLoading());
      await OfferService.counterOffer(
        offerId,
        offeredAmount: offeredAmount,
        requestedPercentage: requestedPercentage,
        message: message,
      );
      emit(CounterOfferCreated());
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }
}