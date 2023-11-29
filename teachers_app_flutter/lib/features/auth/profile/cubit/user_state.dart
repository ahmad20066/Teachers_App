part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserDeleteSuccess extends UserState {}

class UserDeleting extends UserState {}

class UserDeleteError extends UserState {
  final String error;

  UserDeleteError(this.error);
}

class UserExpired extends UserState {}

class UserError extends UserState {
  final String error;

  UserError(this.error);
}

class UserLoaded extends UserState {
  final user;

  UserLoaded(this.user);
}
