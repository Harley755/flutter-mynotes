import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister({required this.email, required this.password});
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogin(
    this.email,
    this.password,
  );
}

class AuthEventForgotPassword extends AuthEvent {
  final String? email;
  const AuthEventForgotPassword({this.email});
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
