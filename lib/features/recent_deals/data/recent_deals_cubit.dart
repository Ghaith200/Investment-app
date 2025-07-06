import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/recent_deals/data/deals_repo.dart';
import 'package:investement_app/features/recent_deals/data/recent_deals_state.dart';

class DealsCubit extends Cubit<DealsState> {
  final DealsRepository repository;

  DealsCubit(this.repository) : super(DealsInitial());

  Future<void> fetchRecentDeals() async {
    emit(DealsLoading());
    try {
      final deals = await repository.fetchRecentDeals();
      emit(DealsLoaded(deals));
    } catch (e) {
      emit(DealsError(e.toString()));
    }
  }
}
