part of 'schedule_cubit.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<RequestModel> requests;

  ScheduleLoaded(this.requests);
}

class ScheduleLoading extends ScheduleState {}

class ScheduleEmpty extends ScheduleState {}

class ScheduleError extends ScheduleState {
  final String error;

  ScheduleError(this.error);
}
