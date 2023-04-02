import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_learn/authentication/bloc/state/authentication_state.dart';
import 'package:let_learn/authentication/repository/authentication_repository.dart';

import '../repository/models/user.dart';
import 'events/authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationEventAppStarted>(_onAppStarted);
    on<AuthenticationEventLoggedIn>(_onLoggedIn);
    on<AuthenticationEventLoggedOut>(_onLoggedOut);
    on<AuthenticationEventRegister>(_onRegister);
    on<AuthenticationEventLogin>(_onLogin);
    on<AuthenticationEventForgotPassword>(_onForgotPassword);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onAppStarted(
      AuthenticationEventAppStarted event,
      Emitter<AuthenticationState> emit,
      ) async {
    try {
      final isSignedIn = await _authenticationRepository.isSignedIn();
      if (isSignedIn) {
        final tokenAndUser = await _authenticationRepository.getTokenAndUser();
        emit(AuthenticationState.authenticated(
            tokenAndUser['user'], tokenAndUser['token']));
      } else {
        emit(AuthenticationState.unauthenticated());
      }
    } catch (_) {
      emit(AuthenticationState.unauthenticated());
    }
  }

  void _onLoggedIn(
      AuthenticationEventLoggedIn event,
      Emitter<AuthenticationState> emit,
      ) async {
    emit(AuthenticationState.authenticated(event.user, event.token));
  }

  void _onLoggedOut(
      AuthenticationEventLoggedOut event,
      Emitter<AuthenticationState> emit,
      ) async {
    _authenticationRepository.signOut();
    emit(AuthenticationState.unauthenticated());
  }

  void _onRegister(
      AuthenticationEventRegister event,
      Emitter<AuthenticationState> emit,
      ) async {
    try {
      final response = await _authenticationRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        date_of_birth: event.date_of_birth,
      );
      print("Register Bloc | Response: ${response.body}");
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final user = User.fromJson(body['data']['user']);
        final token = body['data']['access_token'];
        emit(AuthenticationState.authenticated(user, token));
      } else if (response.statusCode == 422) {
        emit(AuthenticationState.failure("Email already exists"));
      } else {
        emit(AuthenticationState.failure(body['message']));
      }
    } catch (e) {
      emit(AuthenticationState.failure(e.toString()));
    }
  }
  void _onLogin(
      AuthenticationEventLogin event,
      Emitter<AuthenticationState> emit,
      ) async {
    try {
      emit(AuthenticationState.loading());
      final response = await _authenticationRepository.login(
        email: event.email,
        password: event.password,
      );
      print("Login Bloc | Response: ${response.body}");
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body['data']['user']['email_verified_at'] == null) {
          emit(AuthenticationState.failure("Please verify your email"));
        } else {
          final user = User.fromJson(body['data']['user']);
          final token = body['data']['access_token'];
          _authenticationRepository.setTokenAndUser(token, user);
          emit(AuthenticationState.authenticated(user, token));
        }
      } else if (response.statusCode == 401) {
        emit(AuthenticationState.failure("Invalid credentials"));
      } else {
        emit(AuthenticationState.failure(body['message']));
      }
    } catch (e) {
      emit(AuthenticationState.failure(e.toString()));
    }
  }
  void _onForgotPassword(
      AuthenticationEventForgotPassword event,
      Emitter<AuthenticationState> emit,
      ) async {
    try {
      print("Forgot Password Bloc | Email: ${event.email}");
      await _authenticationRepository.forgotPassword(event.email);
      emit(AuthenticationState.forgotPassword());
    } catch (e) {
      emit(AuthenticationState.failure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
