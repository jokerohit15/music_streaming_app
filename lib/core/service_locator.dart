import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_streaming_app/data/respositories/auth_repository_impl.dart';
import 'package:music_streaming_app/domain/repositories/auth_repository.dart';
import 'package:music_streaming_app/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:music_streaming_app/presentation/bloc/login/login_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Firebase Auth instance
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );

  // Use Cases
  getIt.registerLazySingleton<SignInWithEmailAndPassword>(
        () => SignInWithEmailAndPassword(getIt<AuthRepository>()),
  );

  // Cubits/Blocs
  getIt.registerFactory<LoginCubit>(
        () => LoginCubit(getIt<SignInWithEmailAndPassword>()),
  );
}
