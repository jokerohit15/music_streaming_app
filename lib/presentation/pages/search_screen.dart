import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';
import 'package:music_streaming_app/core/extensions/extension.dart';
import 'package:music_streaming_app/core/service_locator.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/main/main_state.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_cubit.dart';
import 'package:music_streaming_app/presentation/bloc/search/search_state.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search",style: Theme.of(context).textTheme.displayLarge),
            Container(
              width: 1.sw,
              height: 0.07.sh,
              margin: EdgeInsets.symmetric(vertical: 0.03.sh),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).primaryColor,
              ),
              child: TextField(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColorLight),
                onChanged: (value) {
                  context.read<MainCubit>().searchSongs(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.1.sw,vertical: 0.025.sh),
                  hintText: 'Search',
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
                  suffixIcon: const Icon(Icons.search),
                  suffixIconColor: Theme.of(context).primaryColorLight,
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  if (state is MainLoaded || state is MainSearchedSong) {
                    final songList = state is MainLoaded ? state.songList : state is MainSearchedSong ? state.songList : [];
                    return ListView.builder(
                      itemCount: songList.length,
                      itemBuilder: (context, index) {
                        final song = songList[index];
                        return ListTile(
                          title: Text(song.name),
                          subtitle: Text(song.artist.first),
                          leading: Image.network(song.albumArt, width: 50, height: 50),
                        );
                      },
                    );
                  }
                  else if (state is MainError) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 0.02.sw),
      ),
    );
  }
}
