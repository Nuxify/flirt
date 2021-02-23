part of 'record_cubit.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.loginResponse);

  final RecordRepository loginResponse;
}

class LoginFailed extends LoginState {
  const LoginFailed(this.errorCode, this.message);

  final String errorCode;
  final String message;
}
