import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/presentation/bloc/home/home_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_cubit.dart';
import 'package:music_streaming_app/presentation/pages/home_screen/home_screen.dart';
import 'package:music_streaming_app/presentation/pages/profile_screen.dart';
import 'package:music_streaming_app/presentation/pages/search_screen.dart';
import 'package:music_streaming_app/presentation/widgets/navigator_bar.dart';
import 'package:music_streaming_app/presentation/widgets/now_playing_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> children = [
    const HomeScreen(),
    BlocProvider<SearchCubit>(
        create: (context) => getIt<SearchCubit>()..initCall(context),
        child : const SearchScreen()),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    return BlocProvider<MainCubit>(
      create: (context) => getIt<MainCubit>(),
      child: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  if (isWideScreen) const NavigatorBar(),
                  Expanded(
                      child: children[context.read<MainCubit>().currentIndex]),
                ],
              ),
            ),
            bottomNavigationBar: isWideScreen ? null
                : SizedBox(
              height: 0.15.heightSize(context),
                  child: const Stack(
                    children: [
                    Positioned.fill(child: NowPlayingWidget()),
                      Align(alignment:Alignment.bottomCenter,child: NavigatorBar()),
                    ],
                  ),
                ),
          ),
        );
      }),
    );
  }
}
