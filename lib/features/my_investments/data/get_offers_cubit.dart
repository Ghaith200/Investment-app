import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/my_investments/data/get_offers_state.dart';
import 'package:investement_app/features/my_investments/service/get_offer_services.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  Future<void> loadOffers() async {
    emit(OffersLoading());
    try {
      final offers = await OfferService.getMyOffers();
      emit(OffersLoaded(offers));
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }
}
