import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/details/details_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/routes/app_routes.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    ///how to initialize web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCXY82vZFf29gvWF6QiSWlTEoaGj2qhodU",
          authDomain: "practice-projects-7c9bf.firebaseapp.com",
          projectId: "practice-projects-7c9bf",
          storageBucket: "practice-projects-7c9bf.appspot.com",
          messagingSenderId: "48580419363",
          appId: "1:48580419363:web:4916330dbe35bf9b7b3696",
          measurementId: "G-XVKCBC5TN1"),
    );
    await FirebaseFirestore.instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: false))
        .catchError((e) {
      if (e.code == 'failed-precondition') {
      } else if (e.code == 'unimplemented') {
      }
    });
    FirebaseFirestore.instance.settings.persistenceEnabled;
  } else {
    await Firebase.initializeApp();
  }
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ///to save settings when no internet is there
  firestore.settings = const Settings(persistenceEnabled: true);
  setupLocator();
  runApp(
    ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MyApp();
        }),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => getIt<HomeCubit>()..initCall(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<ThemeProvider>()..assignTheme(context),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider<DetailsCubit>(
          create: (context) => getIt<DetailsCubit>(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return MaterialApp(
          theme: themeProvider.currentTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      }),
    );
  }
}

