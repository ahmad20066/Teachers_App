part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class TutorsLoading extends SearchState {}

class TutorsLoaded extends SearchState {
  final List<TutorModel> tutors;

  TutorsLoaded(this.tutors);
}

class TutorsError extends SearchState {
  final String error;

  TutorsError(this.error);
}

class TutorsEmpty extends SearchState {}
