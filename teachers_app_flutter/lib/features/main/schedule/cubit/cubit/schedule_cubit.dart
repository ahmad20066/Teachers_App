import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/models/request/request_model.dart';

import '../../../services/tutors_service.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleInitial());
  getTeacherSchedule() async {
    try {
      emit(ScheduleLoading());
      final requests = await TutorsService().getScheduleRequests();

      if (requests.isEmpty) {
        emit(ScheduleEmpty());
      } else {
        emit(ScheduleLoaded(requests));
      }
    } catch (e) {
      print(e);
      emit(ScheduleError(e.toString()));
    }
  }
}
