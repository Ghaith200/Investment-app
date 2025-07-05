import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/home/data/offer_state.dart';
import 'package:investement_app/features/home/models/offer_model.dart';
import 'package:investement_app/features/home/service/make_offer_service.dart';


class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial());

  Future<void> createOffer(OfferModel offer) async {
    emit(OfferCreating());
    try {
      final createdOffer = await OfferService.createOffer(offer);
      emit(OfferCreated(createdOffer));
    } catch (e) {
      emit(OfferError(e.toString()));
    }
  }
}