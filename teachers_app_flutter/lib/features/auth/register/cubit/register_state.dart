part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final bool success;

  RegisterSuccess(this.success);
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}

class RegisterLoading extends RegisterState {}

class SendingCode extends RegisterState {}

class CodeSent extends RegisterState {}

class CodeError extends RegisterState {
  final String error;

  CodeError(this.error);
}

class VerifyLoading extends RegisterState {}

class VerifySuccess extends RegisterState {}

class ToVerify extends RegisterState {}

class VerifyError extends RegisterState {
  final String error;

  VerifyError(this.error);
}
