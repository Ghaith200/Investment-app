import 'package:flutter/foundation.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutFailure extends LogoutState {
  final String message;
  LogoutFailure(this.message);
}
