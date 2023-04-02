import 'package:equatable/equatable.dart';

import '../../repository/models/user.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationEventAppStarted extends AuthenticationEvent {
  const AuthenticationEventAppStarted();

  @override
  List<Object> get props => [];
}

class AuthenticationEventLoggedIn extends AuthenticationEvent {
  const AuthenticationEventLoggedIn(this.user, this.token);

  final User user;
  final String token;

  @override
  List<Object> get props => [user, token];
}

class AuthenticationEventLoggedOut extends AuthenticationEvent {
  const AuthenticationEventLoggedOut();

  @override
  List<Object> get props => [];
}

class AuthenticationEventRegister extends AuthenticationEvent {
  const AuthenticationEventRegister(this.name, this.email, this.password, this.date_of_birth);

  final String name;
  final String email;
  final String password;
  final String date_of_birth;

  @override
  List<Object> get props => [name, email, password];
}

class AuthenticationEventLogin extends AuthenticationEvent {
  const AuthenticationEventLogin(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthenticationEventForgotPassword extends AuthenticationEvent {
  const AuthenticationEventForgotPassword(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}
