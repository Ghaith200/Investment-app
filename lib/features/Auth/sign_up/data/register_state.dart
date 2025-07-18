// register_state.dart
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String token;
  RegisterSuccess(this.token);
}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);
}
