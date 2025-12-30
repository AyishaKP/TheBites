import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  late final StreamSubscription _sub;

  AuthCubit(this.repo) : super(const AuthState()) {
    _sub = repo.authStateChanges().listen((user) {
      emit(state.copyWith(
        status: user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated,
        loading: false,
        error: null,
      ));
    });
  }

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await repo.signIn(email, password);
      // authStateChanges will update status
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> signOut() => repo.signOut();

  Future<void> sendPasswordReset(String email) async {
    try {
      await repo.sendPasswordReset(email);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}