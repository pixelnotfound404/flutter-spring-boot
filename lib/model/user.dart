import 'dart:convert';

class loginResponse {
  final String token;
  final String expiresIn;

  loginResponse({required this.token, required this.expiresIn});

  factory loginResponse.fromJson(Map<String, dynamic> json) {
    return loginResponse(
      token: json['token']?.toString() ?? '',
      expiresIn: json['expiresIn']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'expiresIn': expiresIn};
  }
}

class RegisterResponse {
  final String token;
  final int expiresIn;
  final String otp;
  final int userId;
  final String username;
  final String fullName;
  final String email;
  final String passwordHash;
  final bool verified;
  final DateTime createdAt;
  final String message;

  RegisterResponse({
    required this.token,
    required this.expiresIn,
    required this.otp,
    required this.userId,
    required this.username,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    required this.verified,
    required this.createdAt,
    required this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json['token'],
      expiresIn: json['expiresIn'],
      otp: json['otp'],
      userId: json['userId'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      passwordHash: json['passwordHash'],
      verified: json['verified'],
      createdAt: DateTime.parse(json['createdAt']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiresIn': expiresIn,
      'otp': otp,
      'userId': userId,
      'username': username,
      'fullName': fullName,
      'email': email,
      'passwordHash': passwordHash,
      'verified': verified,
      'createdAt': createdAt.toIso8601String(),
      'message': message,
    };
  }
}


class User {
  final int id;
  final String fullname;
  final String email;
  final String password;
  final String createdAt;
  final String updatedAt;
  final bool verified;
  final bool enabled;
  final List<dynamic> authorities;
  final bool accountNonExpired;
  final bool credentialsNonExpired;
  final bool accountNonLocked;
  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.verified,
    required this.enabled,
    required this.authorities,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
    required this.accountNonLocked,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'verified': verified,
      'enabled': enabled,
      'authorities': authorities,
      'accountNonExpired': accountNonExpired,
      'credentialsNonExpired': credentialsNonExpired,
      'accountNonLocked': accountNonLocked,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      verified: map['verified'] as bool,
      enabled: map['enabled'] as bool,
      authorities: List<dynamic>.from((map['authorities'] as List<dynamic>)),
      accountNonExpired: map['accountNonExpired'] as bool,
      credentialsNonExpired: map['credentialsNonExpired'] as bool,
      accountNonLocked: map['accountNonLocked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
