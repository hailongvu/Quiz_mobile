import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.roleId,
    required this.username,
    required this.email,
    required this.dateOfBirth,
    required this.status,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  final int id;
  final int roleId;
  final String username;
  final String email;
  final String dateOfBirth;
  final String status;
  final String emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: json['id'] as int,
      roleId: json['role_id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      status: json['status'] as String,
      emailVerifiedAt: json['email_verified_at'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['role_id'] = roleId;
    _data['username'] = username;
    _data['email'] = email;
    _data['date_of_birth'] = dateOfBirth;
    _data['status'] = status;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }

  @override
  List<Object> get props => [
    id,
    roleId,
    username,
    email,
    dateOfBirth,
    status,
    emailVerifiedAt,
    createdAt,
    updatedAt,
  ];

  static const empty = User(
    id: 0,
    roleId: 0,
    username: '',
    email: '',
    dateOfBirth: '',
    status: '',
    emailVerifiedAt: '',
    createdAt: '',
    updatedAt: '',
  );
}
