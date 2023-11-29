part of 'forgot_cubit.dart';

@immutable
abstract class ForgotState {}

class ForgotInitial extends ForgotState {}

class ForgotLoading extends ForgotState {}

class ForgotSuccess extends ForgotState {}

class ForgotError extends ForgotState {
  final String error;

  ForgotError(this.error);
}
