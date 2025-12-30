import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../login/data/datasources/auth_remote_datasource.dart';
import '../../login/data/repositories/auth_repository_impl.dart';
import '../../login/domain/repositories/auth_repository.dart';
import '../../login/presentation/auth/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> setupInjection() async {
  // Firebase SDK
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Datasource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  // Cubit
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(sl<AuthRepository>()),
  );
}