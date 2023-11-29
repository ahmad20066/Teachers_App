import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/features/main/services/student_services.dart';
import 'package:teachers_app/features/main/services/tutors_service.dart';
import 'package:teachers_app/models/request/request_model.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(RequestInitial());
  addRequest(String id, DateTime date, String subject) async {
    try {
      emit(RequestLoading());
      final success = await StudentServices()
          .sendRequest(id, date.toIso8601String(), subject);
      if (success) {
        emit(RequestSuccess());
      }
    } catch (e) {
      print(e);
      emit(RequestError(e.toString()));
    }
  }

  cancelRequest(String id) async {
    try {
      final success = await StudentServices().cancelRequest(id);
      if (success) {
        return true;
      }
    } catch (e) {
      print(e);
      // emit(RequestError(e.toString()));
      return false;
    }
  }

  getRequestsStudent() async {
    try {
      emit(RequestsListLoading());
      final requests = await StudentServices().getRequests();

      if (requests.isEmpty) {
        emit(RequestsEmpty());
      } else {
        emit(RequestLoaded(requests));
      }
    } catch (e) {
      print(e);
      emit(RequestError(e.toString()));
    }
  }

  getTeacherRequests() async {
    try {
      emit(RequestsListLoading());
      final requests = await TutorsService().getRequests();

      if (requests.isEmpty) {
        emit(RequestsEmpty());
      } else {
        emit(RequestLoaded(requests));
      }
    } catch (e) {
      print(e);
      emit(RequestError(e.toString()));
    }
  }

  acceptRequest(String id, String comment) async {
    try {
      final success = await TutorsService().acceptRequest(id, comment: comment);
      if (success) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  rejectRequest(String id, String comment) async {
    try {
      final success = await TutorsService().rejectRequest(id, comment: comment);
      if (success) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
