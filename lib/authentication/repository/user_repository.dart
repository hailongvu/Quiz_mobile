import 'dart:async';

import 'models/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    await Future.delayed(const Duration(seconds: 2));
    _user = const User(
      id: 1,
      roleId: 1,
      username: 'admin',
      email: '',
      dateOfBirth: '',
      status: '',
      emailVerifiedAt: '',
      createdAt: '',
      updatedAt: '',
    );
  }
}
