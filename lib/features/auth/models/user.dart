import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Modelo de usuario autenticado
@freezed
abstract class User with _$User {
  const factory User({
    required String username,
    DateTime? lastLogin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// Estado de autenticación
@freezed
sealed class AuthState with _$AuthState {
  /// Usuario no autenticado
  const factory AuthState.unauthenticated() = Unauthenticated;

  /// Proceso de autenticación en curso
  const factory AuthState.loading() = Loading;

  /// Usuario autenticado exitosamente
  const factory AuthState.authenticated(User user) = Authenticated;

  /// Error de autenticación
  const factory AuthState.error(String message) = AuthError;
}
