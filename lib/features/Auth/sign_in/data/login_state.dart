import 'package:investement_app/core/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
