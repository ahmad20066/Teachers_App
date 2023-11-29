import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/tutor/tutor_model.dart';
import '../../services/tutors_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  getpopularTutors() async {
    try {
      emit(PopularTutorsLoading());
      //TODO: show = true
      List<TutorModel> tutors = await TutorsService().getTutors();

      if (tutors.isEmpty) {
        emit(PopularTutorsEmpty());
      } else {
        emit(PopularTutorsLoaded(tutors));
      }
    } catch (e) {
      print(e);
      emit(PopularTutorsError(e.toString()));
      rethrow;
    }
  }
}
