import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  AuthRemoteDataSource(this.auth, this.db);

  Stream<User?> authStateChanges() => auth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() => auth.signOut();

  Future<void> sendPasswordReset(String email) => auth.sendPasswordResetEmail(email: email);
}