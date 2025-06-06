import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class loginResponse {
  final String token;
  final String expiresIn;

  loginResponse({required this.token, required this.expiresIn});

  factory loginResponse.fromJson(Map<String, dynamic> json) {
    return loginResponse(token: json['token'], expiresIn: json['expiresIn']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'expiresIn': expiresIn};
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
