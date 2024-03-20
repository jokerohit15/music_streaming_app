import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/core/theme/app_theme.dart';
import 'package:music_streaming_app/core/theme/theme_provider.dart';
import 'package:music_streaming_app/presentation/bloc/login/login_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_cubit.dart';
import 'package:music_streaming_app/presentation/pages/details_screen.dart';
import 'package:music_streaming_app/presentation/pages/home_screen.dart';
import 'package:music_streaming_app/presentation/pages/login_screen.dart';
import 'package:music_streaming_app/presentation/pages/main_screen.dart';
import 'package:music_streaming_app/presentation/pages/search_screen.dart';
import 'package:music_streaming_app/presentation/widgets/music_list.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  const MyApp();
      }),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
        create: (context) => getIt<SearchCubit>(),
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return  MaterialApp(
               // home: const HomeScreen(),
               // home: DetailsScreen(),
                home: MainScreen(),
                theme: themeProvider.currentTheme,
              );
            },
          ),
        ),
    );
  }
}
