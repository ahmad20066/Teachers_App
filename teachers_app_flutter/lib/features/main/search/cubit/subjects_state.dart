part of 'subjects_cubit.dart';

@immutable
abstract class SubjectsState {}

class SubjectsInitial extends SubjectsState {}

class SubjectsLoading extends SubjectsState {}

class SubjectsError extends SubjectsState {
  final String error;

  SubjectsError(this.error);
}

class SubjectsLoaded extends SubjectsState {
  final List<SubjectModel> subjects;

  SubjectsLoaded(this.subjects);
}
