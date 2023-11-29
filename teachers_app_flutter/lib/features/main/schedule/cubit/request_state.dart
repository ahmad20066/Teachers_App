part of 'request_cubit.dart';

@immutable
abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestsListLoading extends RequestState {}

class TeacherScheduleLoading extends RequestState {}

class TeacherScheduleEmpty extends RequestState {}

class TeacherScheduleLoaded extends RequestState {
  final List<RequestModel> requests;

  TeacherScheduleLoaded(this.requests);
}

class RequestError extends RequestState {
  final String error;

  RequestError(this.error);
}

class RequestSuccess extends RequestState {}

class RequestLoaded extends RequestState {
  final List<RequestModel> requests;

  RequestLoaded(this.requests);
}

class RequestsEmpty extends RequestState {}
