import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/home/data/logout_state.dart';
import 'package:investement_app/features/home/service/logout_service.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await LogoutService().logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
