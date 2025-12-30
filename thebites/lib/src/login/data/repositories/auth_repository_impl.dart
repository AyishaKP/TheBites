import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Stream<User?> authStateChanges() => remote.authStateChanges();

  @override
  Future<void> signIn(String email, String password) => remote.signIn(email, password);

  @override
  Future<void> signOut() => remote.signOut();

  @override
  Future<void> sendPasswordReset(String email) => remote.sendPasswordReset(email);
}