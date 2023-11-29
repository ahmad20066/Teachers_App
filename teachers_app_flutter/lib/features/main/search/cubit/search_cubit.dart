import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/features/main/services/tutors_service.dart';
import 'package:teachers_app/models/subject/subject_model.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  getTutors({search, subject, alphabet = false}) async {
    try {
      emit(TutorsLoading());
      List<TutorModel> tutors = await TutorsService()
          .getTutors(search: search, subject: subject, alphabet: alphabet);

      if (tutors.isEmpty) {
        emit(TutorsEmpty());
      } else {
        emit(TutorsLoaded(tutors));
      }
    } catch (e) {
      print(e);
      emit(TutorsError(e.toString()));
      rethrow;
    }
  }
}
