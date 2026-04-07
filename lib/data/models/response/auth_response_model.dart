import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthResponseModel {
  final String? userId;
  final String? email;
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;

  AuthResponseModel({
    this.userId,
    this.email,
    this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  factory AuthResponseModel.fromSupabase(AuthResponse res) {
    return AuthResponseModel(
      userId: res.user?.id,
      email: res.user?.email,
      accessToken: res.session?.accessToken,
      refreshToken: res.session?.refreshToken,
      expiresAt: res.session?.expiresAt != null
          ? DateTime.fromMillisecondsSinceEpoch(
              res.session!.expiresAt! * 1000,
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'email': email,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt?.toIso8601String(),
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      userId: map['user_id'],
      email: map['email'],
      accessToken: map['access_token'],
      refreshToken: map['refresh_token'],
      expiresAt: map['expires_at'] != null
          ? DateTime.parse(map['expires_at'])
          : null,
    );
  }
  String toJson() => jsonEncode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(jsonDecode(source));
}