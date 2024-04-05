

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/app_constants/string_constants.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:music_streaming_app/presentation/routes/app_routes.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Future.delayed(const Duration(seconds: 4),(){
            context.navigateTo(AppRoutes.main,null);
          }
          );
        } else if (state is Unauthenticated) {
          Future.delayed(const Duration(seconds: 4) , (){
            context.navigateTo(AppRoutes.loginRegistration,null);
          }
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Text(StringConstants.appTitle,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 50),),
        ),
      ),
    );
  }
}
