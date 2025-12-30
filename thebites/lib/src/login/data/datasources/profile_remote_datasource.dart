import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileRemoteDataSource {
  Future<void> upsertProfile({
    required String uid,
    required String email,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore _db;
  ProfileRemoteDataSourceImpl(this._db);

  @override
  Future<void> upsertProfile({required String uid, required String email}) async {
    final ref = _db.collection('users').doc(uid);
    await ref.set({
      'uid': uid,
      'email': email,
      'updatedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}