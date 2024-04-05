import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/presentation/bloc/login_registration/login_registration_cubit.dart';
import 'package:music_streaming_app/presentation/pages/details_screen/details_screen.dart';
import 'package:music_streaming_app/presentation/pages/login_registration_screen.dart';
import 'package:music_streaming_app/presentation/pages/main_screen.dart';
import 'package:music_streaming_app/presentation/pages/not_found_screen.dart';
import 'package:music_streaming_app/presentation/pages/splash_screen.dart';
import 'package:music_streaming_app/presentation/routes/route_parameters.dart';
import 'package:music_streaming_app/presentation/routes/route_transitions.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String loginRegistration = '/loginRegistration';
  static const String main = '/main';
  static const String details = '/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());


      case loginRegistration:
        return FadeRoute(
            page: BlocProvider<LoginRegistrationCubit>(
                create: (context) => getIt<LoginRegistrationCubit>(),
                child: const LoginRegistrationScreen()));

      case main:
        return MaterialPageRoute(builder: (_) =>  MainScreen());

      case details:
        var args = settings.arguments as DetailsScreenParameters;
        return MaterialPageRoute(
            builder: (_) => DetailsScreen(song: args.song, title: args.title));
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
