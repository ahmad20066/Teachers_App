part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class PopularTutorsEmpty extends HomeState {}

class PopularTutorsLoaded extends HomeState {
  final List<TutorModel> tutors;

  PopularTutorsLoaded(this.tutors);
}

class PopularTutorsLoading extends HomeState {}

class PopularTutorsError extends HomeState {
  final String error;

  PopularTutorsError(this.error);
}
