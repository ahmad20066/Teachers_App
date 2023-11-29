part of 'change_cubit.dart';

@immutable
abstract class ChangeState {}

class ChangeInitial extends ChangeState {}

class ChangeLoadingl extends ChangeState {}

class ChangeSuccess extends ChangeState {}

class ChangeError extends ChangeState {
  final String error;

  ChangeError(this.error);
}
