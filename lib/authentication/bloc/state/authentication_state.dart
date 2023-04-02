import 'package:equatable/equatable.dart';
import '../../repository/models/user.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();
  const AuthenticationState.unknown() : this();

  @override
  List<Object> get props => [];

  static AuthenticationState authenticated(user, token) {
    return AuthenticationStateAuthenticated(user, token);
  }

  static AuthenticationState unauthenticated() {
    return const AuthenticationStateUnauthenticated();
  }

  static AuthenticationState failure(String string) {
    return AuthenticationStateFailure(string);
  }

  static AuthenticationState loading() {
    return const AuthenticationStateLoading();
  }


  static AuthenticationState forgotPassword() {
    return const AuthenticationStateForgotPassword();
  }
}


class AuthenticationStateForgotPassword extends AuthenticationState {
  const AuthenticationStateForgotPassword();

  @override
  List<Object> get props => [];
}

class AuthenticationStateFailure extends AuthenticationState {
  const AuthenticationStateFailure(this.string);

  final String string;

  @override
  List<Object> get props => [string];
}

class AuthenticationStateUnauthenticated extends AuthenticationState {
  const AuthenticationStateUnauthenticated();

  @override
  List<Object> get props => [];
}

class AuthenticationStateAuthenticated extends AuthenticationState {
  const AuthenticationStateAuthenticated(this.user, this.token);

  final User user;
  final String token;

  @override
  List<Object> get props => [user, token];
}

class AuthenticationStateLoading extends AuthenticationState {
  const AuthenticationStateLoading();

  @override
  List<Object> get props => [];
}