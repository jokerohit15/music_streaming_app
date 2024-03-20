import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';
import 'package:music_streaming_app/presentation/pages/home_screen.dart';
import 'package:music_streaming_app/presentation/pages/search_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> _children = [const HomeScreen(), const SearchScreen()];


  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => getIt<MainCubit>()..getSongs(),
      child:    BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: _children[context.read<MainCubit>().currentIndex], // Display the currently selected page
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Theme.of(context).primaryColor,
              onTap:(index) =>context.read<MainCubit>().onTabTap(index), // Update the state when an item is tapped
              currentIndex:context.read<MainCubit>().currentIndex, // This will be set when a new tab is tapped
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
