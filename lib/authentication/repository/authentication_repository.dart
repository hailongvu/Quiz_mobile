import 'dart:async';
import 'dart:convert';
import 'package:let_learn/utils/AppConstant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

final loginUrl = Uri.parse('$baseUrl/auth/login');
final registerUrl = Uri.parse('$baseUrl/auth/register');
final logoutUrl = Uri.parse('$baseUrl/auth/logout');
final forgotPasswordUrl = Uri.parse('$baseUrl/auth/forgot-password');

class AuthenticationRepository {
  final http.Client httpClient;
  // contructor
  AuthenticationRepository({required this.httpClient});

  isSignedIn() {
    return getToken() != null;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return User.fromJson(jsonDecode(prefs.getString('user')!));
  }

  getTokenAndUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('token'),
      'user': User.fromJson(jsonDecode(prefs.getString('user')!))
    };
  }

  setTokenAndUser(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('user', jsonEncode(user));
  }

  void signOut() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
      prefs.remove('user');
    });
  }

  register(
      {required String name, required String email, required String password, required String date_of_birth}) {
    return httpClient.post(
      registerUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'date_of_birth': date_of_birth,
      }),
    );
  }

  login({required String email, required String password}) {
    return httpClient.post(
      loginUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }

  forgotPassword(String email) {
    return httpClient.post(
      forgotPasswordUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
  }
}
