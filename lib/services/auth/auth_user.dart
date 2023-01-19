import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

// @immutable chaque champ dans AuthUser (et ses sous-classes) doit être final
@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified});

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}
