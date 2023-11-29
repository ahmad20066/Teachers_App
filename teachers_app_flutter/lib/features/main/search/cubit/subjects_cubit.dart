import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/features/main/services/tutors_service.dart';
import 'package:teachers_app/models/subject/subject_model.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());
  SubjectModel? selectedSubject;
  getSubjects() async {
    try {
      emit(SubjectsLoading());
      final subjects = await TutorsService().getSubjects();
      if (subjects.isNotEmpty) {
        selectedSubject = subjects.first;
      }

      emit(SubjectsLoaded(subjects));
    } catch (e) {
      emit(SubjectsError(e.toString()));
    }
  }
}
