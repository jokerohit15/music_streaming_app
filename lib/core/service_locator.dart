import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/data/data_sources/local_storage_source.dart';
import 'package:music_streaming_app/data/data_sources/song_remote_data_source.dart';
import 'package:music_streaming_app/data/data_sources/user_remote_data_source.dart';
import 'package:music_streaming_app/data/respositories/auth_repository_impl.dart';
import 'package:music_streaming_app/data/respositories/local_storage_repository_impl.dart';
import 'package:music_streaming_app/data/respositories/song_repository_impl.dart';
import 'package:music_streaming_app/data/respositories/user_repository_impl.dart';
import 'package:music_streaming_app/domain/repositories/auth_repository.dart';
import 'package:music_streaming_app/domain/repositories/local_storage_repository.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';
import 'package:music_streaming_app/domain/repositories/user_repository.dart';
import 'package:music_streaming_app/domain/use_cases/check_authentication.dart';
import 'package:music_streaming_app/domain/use_cases/create_user_with_email_and_password.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_liked_songs.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_monthly_hits.dart';
import 'package:music_streaming_app/domain/use_cases/fetch_songs.dart';
import 'package:music_streaming_app/domain/use_cases/get_theme.dart';
import 'package:music_streaming_app/domain/use_cases/get_user.dart';
import 'package:music_streaming_app/domain/use_cases/get_user_data.dart';
import 'package:music_streaming_app/domain/use_cases/save_theme.dart';
import 'package:music_streaming_app/domain/use_cases/save_user_data.dart';
import 'package:music_streaming_app/domain/use_cases/search_songs.dart';
import 'package:music_streaming_app/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:music_streaming_app/domain/use_cases/sign_out.dart';
import 'package:music_streaming_app/domain/use_cases/toggle_favourite_status.dart';
import 'package:music_streaming_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/like_buton/like_button_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/login_registration/login_registration_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerFactory<LoginRegistrationCubit>(
    () => LoginRegistrationCubit(getIt<SignInWithEmailAndPassword>(),
        getIt<CreateUserWithEmailAndPassword>(), getIt<SaveUserData>(),getIt<GetUser>()),
  );

  getIt.registerFactory<MainCubit>(() => MainCubit(
      ));

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      fetchSongs: getIt<FetchSongs>(),
      fetchMonthlyHits: getIt<FetchMonthlyHits>(),
      fetchLikedSongs: getIt<FetchLikedSongs>(),
      getUserData: getIt<GetUserData>(),
      getUser: getIt<GetUser>(),
    ),
  );

  getIt.registerLazySingleton<ThemeProvider>(
      () => ThemeProvider(getIt<GetTheme>(),getIt<SaveTheme>()));

  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(
      fetchSongs: getIt<FetchSongs>(),
      songsSearch: getIt<SearchSongs>(),
    ),
  );
  getIt.registerFactory<DetailsCubit>(
        () => DetailsCubit(),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<CheckAuthentication>(), getIt<SignOut>()),
  );


  getIt.registerFactory<LikeButtonCubit>(() => LikeButtonCubit(
      toggleFavouriteStatus: getIt<ToggleFavouriteStatus>(),
      getUser: getIt<GetUser>()));



  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerLazySingleton<LocalStorageSource>(
        () => LocalStorageSourceImpl( sharedPreferences),
  );

  getIt.registerLazySingleton<LocalStorageRepository>(
        () => LocalStorageRepositoryImpl(localStorageSource: getIt() ));

  getIt.registerLazySingleton<GetTheme>(() => GetTheme(localRepository: getIt<LocalStorageRepository>()));
  getIt.registerLazySingleton<SaveTheme>(() => SaveTheme(localRepository: getIt<LocalStorageRepository>()));

  getIt.registerLazySingleton<SongRemoteDataSource>(
    () => SongRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<SongRepository>(
          () => SongRepositoryImpl(remoteDataSource: getIt()));

  getIt.registerLazySingleton<FetchSongs>(() => FetchSongs(getIt()));
  getIt
      .registerLazySingleton<FetchMonthlyHits>(() => FetchMonthlyHits(getIt()));
  getIt.registerLazySingleton<FetchLikedSongs>(() => FetchLikedSongs(getIt()));
  getIt.registerLazySingleton<SearchSongs>(() => SearchSongs(getIt()));
  getIt.registerLazySingleton<ToggleFavouriteStatus>(
          () => ToggleFavouriteStatus(getIt()));

  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );


  getIt.registerLazySingleton<CheckAuthentication>(
          () => CheckAuthentication(getIt()));
  getIt.registerLazySingleton<GetUser>(() => GetUser(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SaveUserData>(
          () => SaveUserData(getIt<UserRepository>()));
  getIt.registerLazySingleton<GetUserData>(() => GetUserData(
    userRepository: getIt<UserRepository>(),
  ));

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: getIt()));

  getIt.registerLazySingleton<SignInWithEmailAndPassword>(
    () => SignInWithEmailAndPassword(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<CreateUserWithEmailAndPassword>(
    () => CreateUserWithEmailAndPassword(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignOut>(
    () => SignOut(getIt<AuthRepository>()),
  );



}
