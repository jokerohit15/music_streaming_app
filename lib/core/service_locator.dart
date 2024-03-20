import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_streaming_app/data/data_sources/song_remote_data_source.dart';
import 'package:music_streaming_app/data/respositories/auth_repository_impl.dart';
import 'package:music_streaming_app/data/respositories/song_repository_impl.dart';
import 'package:music_streaming_app/domain/repositories/auth_repository.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_monthly_hits.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/login/login_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {


  getIt.registerFactory<SearchCubit>(
        () => SearchCubit(),
  );

  getIt.registerFactory<HomeCubit>(
        () => HomeCubit(),
  );
  getIt.registerFactory<MainCubit>(
        () => MainCubit(fetchSongs:getIt<FetchSongs>(),fetchMonthlyHits: getIt<FetchMonthlyHits>()));

  getIt.registerLazySingleton<SongRepository>(() => SongRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<FetchSongs>(() => FetchSongs(getIt()));
  getIt.registerLazySingleton<FetchMonthlyHits>(() => FetchMonthlyHits(getIt()));

  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data Sources
  getIt.registerLazySingleton<SongRemoteDataSource>(
        () => SongRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );
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
