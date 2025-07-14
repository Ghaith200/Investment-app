import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/zoom_meetings/models/zoom_meeting_model.dart';
import 'package:investement_app/features/zoom_meetings/service/zoom_meeting_service.dart';

abstract class ZoomMeetingState {}

class ZoomMeetingInitial extends ZoomMeetingState {}

class ZoomMeetingLoading extends ZoomMeetingState {}

class ZoomMeetingLoaded extends ZoomMeetingState {
  final ZoomMeetingModel meeting;
  ZoomMeetingLoaded(this.meeting);
}

class ZoomMeetingError extends ZoomMeetingState {
  final String message;
  ZoomMeetingError(this.message);
}

class ZoomMeetingCubit extends Cubit<ZoomMeetingState> {
  final ZoomMeetingService service;

  ZoomMeetingCubit(this.service) : super(ZoomMeetingInitial());

  void createMeeting({
    required String topic,
    required String agenda,
    required String startTime,
    required int duration,
  }) async {
    emit(ZoomMeetingLoading());
    try {
      final meeting = await service.createMeeting(
        topic: topic,
        agenda: agenda,
        startTime: startTime,
        duration: duration,
      );
      emit(ZoomMeetingLoaded(meeting));
    } catch (e) {
      emit(ZoomMeetingError(e.toString()));
    }
  }
}
