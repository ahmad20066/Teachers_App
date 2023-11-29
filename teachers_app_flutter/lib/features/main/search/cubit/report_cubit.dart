import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/features/main/services/student_services.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
  report(teacher_id, reason) async {
    try {
      emit(ReportLoading());
      final success = await StudentServices().report(teacher_id, reason);
      if (success) {
        emit(ReportSucces());
      }
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }
}
