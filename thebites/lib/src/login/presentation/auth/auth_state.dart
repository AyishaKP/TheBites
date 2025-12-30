import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final bool loading;
  final String? error;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.loading = false,
    this.error,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    bool? loading,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, loading, error];
}