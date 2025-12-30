import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repo;
  SignInUseCase(this._repo);

  Future<void> call(String email, String password) {
    return _repo.signIn(email, password);
  }
}